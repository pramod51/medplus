import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:image_cropper/image_cropper.dart';

class ScannerController extends GetxController {
  final images = <XFile>[].obs;
  final selectedIndex = 0.obs;
  final scrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();

    openCamera();
  }

  void openCamera() async {
    if (!await AppUtils.hasAcceptedPermissions()) {
      return;
    }
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      if (images.isEmpty) Get.back();
      return;
    }
    images.add(imageFile);
    selectedIndex.value = images.length - 1;
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: images[selectedIndex.value].path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Palette.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop',
        ),
      ],
    );

    if (croppedFile == null) return;
    images[selectedIndex.value] = XFile(croppedFile.path);
  }

  void onDeleteImage() {
    images.removeAt(selectedIndex.value);
    selectedIndex.value = max(selectedIndex.value - 1, 0);
    if (images.isEmpty) {
      Get.back();
    }
  }

  void onDoneClicked() {
    Get.back();
  }
}
