import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/scanner/scanner_controller.dart';
import 'package:medplus/widgets/app_button.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({Key? key}) : super(key: key);
  final controller = Get.put(ScannerController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.images.isEmpty && controller.selectedIndex.value == 0) {
          return const SizedBox.shrink();
          // return Material(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       AppElevatedBtn(
          //         text: 'Start Capturing Report',
          //         onPressed: controller.openCamera,
          //       )
          //     ],
          //   ),
          // );
        }
        return Column(
          children: [
            Expanded(
              child: Image.file(
                File(controller.images[controller.selectedIndex.value].path),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: ListView.separated(
                controller: controller.scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: controller.images.length + 1,
                itemBuilder: (_, index) {
                  if (index == controller.images.length) {
                    return addImage;
                  } else {
                    return GestureDetector(
                      onTap: () => controller.selectedIndex.value = index,
                      child: Container(
                        width: 100,
                        decoration: controller.selectedIndex.value == index
                            ? BoxDecoration(
                                border: Border.all(
                                    color: Palette.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(controller.images[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 20),
                Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 39,
                      width: 39,
                      color: Colors.white,
                      child: IconButton(
                        onPressed: controller.cropImage,
                        icon: const Icon(Icons.edit),
                        splashRadius: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 39,
                      width: 39,
                      color: Colors.white,
                      child: IconButton(
                        onPressed: controller.onDeleteImage,
                        icon: const Icon(Icons.delete),
                        splashRadius: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppElevatedBtn(
                    text: 'Done',
                    onPressed: controller.onDoneClicked,
                  ),
                ),
                const SizedBox(width: 20)
              ],
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget get addImage {
    return GestureDetector(
      onTap: controller.openCamera,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              width: 2,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
