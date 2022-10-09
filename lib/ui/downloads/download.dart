import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/downloads/downlaod_controller.dart';

class Downloads extends AppPage {
  static const routeName = "/downloads";
  Downloads({Key? key}) : super(key: key);
  final controller = Get.put(DownloadController());
  @override
  Widget get appBar => const SizedBox.shrink();
  @override
  Widget get bottomNavigationBar => const SizedBox.shrink();
  @override
  Widget get body {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Downloads'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 23),
              buildDownloadList,
            ],
          ),
        ),
      ],
    );
  }

  Widget get buildDownloadList {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.files.length,
        itemBuilder: (_, index) {
          final file = controller.files[index];
          if (!file.path.toLowerCase().endsWith('.pdf')) {
            return const SizedBox.shrink();
          }
          final list = file.path.split('Medplus/').last.split(' ');
          if (!list.last.endsWith('${SharedConfig.userId}.pdf')) {
            return const SizedBox.shrink();
          }
          if (list.length < 2) {
            return const SizedBox.shrink();
          }
          String name = '';
          String category = '';
          if (list.isNotEmpty) {
            name = list.first.replaceAll('_', ' ');
            if (list.length > 1) {
              category = list[1];
            }
          } else {
            return const SizedBox.shrink();
          }
          print(name);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Palette.lightBlueBg,
              border: Border.all(color: Palette.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 15, top: 8, bottom: 8),
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColor,
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.borderColor,
                ),
                Container(
                  height: 58,
                  padding: const EdgeInsets.only(left: 10, right: 17),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        decoration: BoxDecoration(
                            color: Palette.randomColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => controller.onViewClicked(File(file.path)),
                        child: SvgPicture.asset(
                          Assets.ic_doc,
                          color: Palette.buttonColor,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () => controller.onShareClicked(File(file.path)),
                        child: SvgPicture.asset(Assets.ic_share),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }
}
