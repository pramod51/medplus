import 'dart:io';

import 'package:get/get.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadController extends GetxController {
  RxList<FileSystemEntity> files = <FileSystemEntity>[].obs;
  @override
  void onInit() async {
    super.onInit();
    final isAcceptedPermissions = await AppUtils.hasAcceptedPermissions();
    if (!isAcceptedPermissions) return;
    if (Platform.isAndroid) {
      if (await Directory('/storage/emulated/0/Medplus/').exists()) {
        final allFiles =
            Directory('/storage/emulated/0/Medplus/').listSync(recursive: true);
        files.assignAll(allFiles);
      }
    } else {
      final dir = await getApplicationDocumentsDirectory();
      if (await dir.exists()) {
        final allFiles = dir.listSync(recursive: true);
        files.assignAll(allFiles);
      }
    }
  }

  void onShareClicked(File file) {
    try {
      AppUtils.shareFile(file);
    } catch (e) {
      AppSnackBar.onError('Unabel to share, try again');
    }
  }

  void onViewClicked(File file) {
    try {
      OpenFile.open(file.path);
    } catch (e) {
      AppSnackBar.onError('Unabel to share, try again');
    }
  }
}
