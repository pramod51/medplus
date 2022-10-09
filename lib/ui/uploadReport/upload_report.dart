import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/uploadReport/upload_report_page_controller.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/simple_chip.dart';

class UploadReport extends AppPage {
  UploadReport({Key? key}) : super(key: key);

  static const routeName = "/upload_report";
  static void start(dynamic arguments) {
    Get.toNamed(
      routeName,
      arguments: arguments,
    );
  }

  final controller = Get.find<UploadReportPageController>();

  @override
  Widget get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildSuggestions(),
            const SizedBox(height: 24),
            buildUploadRecord,
            const SizedBox(height: 24),
            buildReportDateAndNextCheckup(),
            const SizedBox(height: 24),
            buildFinishBtn,
            const SizedBox(height: 25),
          ],
        ),
      );

  Widget buildSuggestions() {
    return Obx(() {
      final list = controller.subCategory;
      return wrapContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'cat_suggestions'.tr.format([controller.category.name]),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Palette.textColor,
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 13,
              runSpacing: 11,
              children: [
                for (int i = 0; i < list.length; i++) ...[
                  SimpleChip(
                    text: list[i],
                    onClick: (bool val) {
                      if (val) {
                        controller.selectedSubCategory.add(list[i]);
                      } else {
                        controller.selectedSubCategory
                            .removeWhere((element) => element == list[i]);
                      }
                    },
                  ),
                ]
              ],
            )
          ],
        ),
      );
    });
  }

  Widget get buildUploadRecord {
    return Obx(
      () => wrapContainer(
        padding: const EdgeInsets.fromLTRB(17, 20, 17, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...buildRecodForAndDesc(),
            const SizedBox(height: 8),
            buildActions,
            if (controller.fileName.isNotEmpty) ...[
              const SizedBox(height: 19),
              const Divider(
                height: 0,
                color: Palette.textLight,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.ic_pdf,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.onPdfFileClicked,
                      child: Text(
                        controller.fileName.value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Palette.textColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: controller.onCrossClicked,
                    icon: SvgPicture.asset(
                      Assets.ic_cross,
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget buildReportDateAndNextCheckup() {
    return wrapContainer(
      padding: const EdgeInsets.fromLTRB(0, 19, 0, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildReportDate,
          const SizedBox(height: 21),
          const Divider(
            height: 0,
            color: Color(0xffDADBE7),
          ),
          const SizedBox(height: 18),
          buildNextCheckupDate,
        ],
      ),
    );
  }

  List<Widget> buildRecodForAndDesc() {
    return [
      Row(
        children: [
          Text(
            'upload_record_for'.tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Palette.textLight,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Obx(
              () => Text(
                controller.familyName.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Palette.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 11),
      Text(
        'upload_rec_cam'.tr,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Palette.textLight,
        ),
      ),
    ];
  }

  Widget get buildActions {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: controller.takePicture,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.ic_camera),
                const SizedBox(height: 10),
                Text(
                  'take_a_picture'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Palette.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        const SizedBox(
          height: 80,
          child: VerticalDivider(
            width: 0,
            color: Palette.textLight,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: controller.pickDocument,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.ic_folder),
                const SizedBox(height: 10),
                Text(
                  'upload_report'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Palette.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get buildReportDate {
    return Row(
      children: [
        const SizedBox(width: 25),
        Text(
          'report_date'.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textLight,
          ),
        ),
        const SizedBox(width: 11),
        Obx(
          () => Text(
            controller.reportDate.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Palette.textColor,
            ),
          ),
        ),
        const SizedBox(width: 7),
        GestureDetector(
            onTap: controller.pickReportDate,
            child: SvgPicture.asset(Assets.ic_calendar)),
        const SizedBox(width: 20),
        SvgPicture.asset(Assets.ic_info),
      ],
    );
  }

  Widget get buildNextCheckupDate {
    return Row(
      children: [
        const SizedBox(width: 24),
        Flexible(
          child: Text(
            'reminder_for_next_checkup'.tr,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Palette.textLight,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Obx(
          () => Text(
            controller.reminderDate.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Palette.textColor,
            ),
          ),
        ),
        const SizedBox(width: 7),
        GestureDetector(
            onTap: controller.pickReminderDate,
            child: SvgPicture.asset(Assets.ic_calendar)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget get buildFinishBtn {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppElevatedBtn(
          width: 140,
          text: 'finish'.tr,
          onPressed: controller.uploadReport,
        ),
      ],
    );
  }

  Widget wrapContainer(
      {required Widget child,
      EdgeInsets padding = const EdgeInsets.fromLTRB(11, 14, 11, 20)}) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Palette.borderColor),
          color: Palette.lightBlueBg,
        ),
        padding: padding,
        child: child);
  }
}
