import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page_controller.dart';
import 'package:medplus/ui/scanner/doc_scanner.dart';
import 'package:medplus/ui/scanner/scanner_controller.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadReportPageController extends GetxController {
  final reportDate = ''.obs;
  final reminderDate = ''.obs;
  final apiStatus = emptyTuple.obs;
  final uploadProgress = 1.obs;
  final familyName = ''.obs;
  int? familyId;
  final fileName = ''.obs;
  Category category = Category.fromMap({});
  final selectedSubCategory = <String>[];
  final subCategory = <String>[].obs;

  File? file;

  @override
  void onReady() {
    super.onReady();
    Get.delete<ScannerController>();
    familyName.value = Get.arguments[0].toString();
    category = Get.arguments[1] as Category;
    familyId = Get.arguments[2];
    debugPrint(
        familyName + "\n" + category.toString() + "\n" + familyId.toString());
    subCategory.assignAll(category.subCategory.split(','));
    selectedSubCategory.clear();
    reminderDate.value =
        DateTime.now().add(const Duration(days: 7)).format('dd/MM/yyyy');
    reportDate.value = DateTime.now().format('dd/MM/yyyy');
  }

  void pickReminderDate() async {
    final date = await mat.showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    reminderDate.value = date.format('dd/MM/yyyy');
  }

  void pickReportDate() async {
    final date = await mat.showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100),
    );
    if (date == null) return;
    reportDate.value = date.format('dd/MM/yyyy');
  }

  void uploadReport() async {
    if (file == null || file?.path == null) {
      AppSnackBar.onError('Please add report file');
      return;
    }
    print(file?.path);
    // return;
    final data = await dio.MultipartFile.fromFile(
      file!.path,
      filename: reminderDate.value,
    );
    apiStatus.value = loadingTuple;
    showProgress();
    final service = Get.put(ApiService());
    final apiResponse = await service.uploadReport(
      data: data,
      familyId: familyId,
      categoryId: category.id,
      nextCheckupDate: reminderDate.value,
      reportDate: reportDate.value,
      subCategory: selectedSubCategory.join(','),
      onUploadProgress: (int progress) {
        uploadProgress.value = progress;
        print(progress);
      },
    );

    if (apiResponse.success) {
      final responseData = AddReport.fromMap(apiResponse.data);
      if (responseData.data != null) {
        final savedPath = await AppUtils.reportsDirPath(
            fileName: familyName.value.updatedName + ' ' + category.name,
            reportId: responseData.data!.id);
        await file?.copy(savedPath);
        final tempdir = Directory(await AppUtils.tempDirPath());
        if (await tempdir.exists()) {
          await tempdir.delete();
        }
        print(responseData.data);
        Get.find<HomePageController>()
            .reportList
            .insert(0, responseData.data!..categoryName = category.name);

        hideProgress();
        Get.back();
        AppSnackBar.onSuccess('Your report successfully uploaded');
      } else {
        hideProgress();
        AppSnackBar.onError(responseData.msg);
      }
    } else {
      hideProgress();
      AppSnackBar.onError('Failed to upload, try again');
    }
  }

  void takePicture() async {
    final isAccepted = await AppUtils.requestPermission(Permission.camera) &&
        await AppUtils.hasAcceptedPermissions();
    if (!isAccepted) return;
    await Get.to(() => ScannerPage());
    print('file not=== saved');

    final images = Get.find<ScannerController>().images;
    if (images.isEmpty) {
      Get.delete<ScannerController>();
      return;
    }
    final pdf = pw.Document();
    for (XFile xFile in images) {
      final image = pw.MemoryImage(
        File(xFile.path).readAsBytesSync(),
      );
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        );
      }));
    }
    file = await saveDocument(pdf: pdf);
    if (file == null) {
      print('file not saved');
    } else {
      final savedPath = await AppUtils.reportsDirPath(
        fileName: familyName.value.updatedName + ' ' + category.name,
      );
      fileName.value = savedPath.split('/').last;
    }
  }

  void pickDocument() async {
    final isAccepted = await AppUtils.hasAcceptedPermissions();
    print(isAccepted.toString() + 'kdn');
    if (!isAccepted) return;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    final pdf = pw.Document();

    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        if (result.files[i].path!.isPDFFileName) {
          file = File(result.files[i].path!);
          fileName.value = result.files[i].name;
          return;
        }
        final image = pw.MemoryImage(
          File(result.files[i].path!).readAsBytesSync(),
        );

        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        }));
      }
      file = await saveDocument(pdf: pdf);
      final savedPath = await AppUtils.reportsDirPath(
        fileName: familyName.value.updatedName + ' ' + category.name,
      );
      fileName.value = savedPath.split('/').last;
    } else {
      print('User canceled the picker');
      // User canceled the picker
    }
  }

  Future<File?> saveDocument({
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    try {
      final path = await AppUtils.tempDirPath();
      final file = File(path);
      file.writeAsBytesSync(bytes);

      return file;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<UploadReportPageController>();
  }

  void showProgress() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const mat.EdgeInsets.symmetric(horizontal: 24),
        content: mat.Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
          alignment: mat.Alignment.center,
          child: Obx(
            () => mat.CircularProgressIndicator(
              value: uploadProgress / 100,
            ),
          ),
        ),
      ),
    );
  }

  void hideProgress() {
    Get.back();
  }

  void onCrossClicked() {
    file = null;
    fileName.value = '';
    Get.delete<ScannerController>();
  }

  void onPdfFileClicked() async {
    final savedPath = await AppUtils.reportsDirPath(
      fileName: familyName.value.updatedName + ' ' + category.name,
    );
    final newFile = await file?.copy(savedPath);
    await OpenFile.open(newFile!.path);
    await Future.delayed(const Duration(seconds: 5), () {
      newFile.delete();
    });
  }
}
