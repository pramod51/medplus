import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/reportListing/report_listing.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/simple_chip.dart';

class UploadReport extends AppPage {
  UploadReport({Key? key}) : super(key: key);
  static const routeName = "/upload_report";
  static void start() {
    Get.toNamed(routeName);
  }

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
    return wrapContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pathology Suggestions',
            style: TextStyle(
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
              for (int i = 0; i < 16; i++) ...[
                const SimpleChip(text: 'text'),
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget get buildUploadRecord {
    return wrapContainer(
      padding: const EdgeInsets.fromLTRB(17, 20, 17, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...buildRecodForAndDesc(),
          const SizedBox(height: 8),
          buildActions,
        ],
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
        children: const [
          Text(
            'Upload record for ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Palette.textLight,
            ),
          ),
          Expanded(
            child: Text(
              'Jane Cooper',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Palette.primaryColor,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 11),
      const Text(
        'Upload using your camera of add from your Gallery',
        style: TextStyle(
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
            // onTap: () => ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.ic_camera),
                const SizedBox(height: 10),
                const Text(
                  'Take a Picture',
                  style: TextStyle(
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
            // onTap: () => ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.ic_folder),
                const SizedBox(height: 10),
                const Text(
                  'Upload Report',
                  style: TextStyle(
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
        const Text(
          'Report Date:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textLight,
          ),
        ),
        const SizedBox(width: 11),
        const Text(
          '08/30/2022',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textColor,
          ),
        ),
        const SizedBox(width: 7),
        SvgPicture.asset(Assets.ic_calendar),
        const SizedBox(width: 20),
        SvgPicture.asset(Assets.ic_info),
      ],
    );
  }

  Widget get buildNextCheckupDate {
    return Row(
      children: [
        const SizedBox(width: 24),
        const Flexible(
          child: Text(
            'Reminder for next Checkup:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Palette.textLight,
            ),
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          '08/30/2022',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textColor,
          ),
        ),
        const SizedBox(width: 7),
        SvgPicture.asset(Assets.ic_calendar),
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
          text: 'Finish',
          onPressed: () => ReportListing.start(),
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xff2B63CF).withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 0),
            ),
          ],
          color: Colors.white,
        ),
        padding: padding,
        child: child);
  }
}
