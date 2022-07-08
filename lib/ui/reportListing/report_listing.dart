import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/reportListing/report_filter.dart';
import 'package:medplus/widgets/report_tile.dart';

class ReportListing extends AppPage {
  ReportListing({Key? key}) : super(key: key);
  static const routeName = "/report_listing";
  static void start() {
    Get.toNamed(routeName);
  }

  @override
  Widget get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 25),
            buildAllNames(),
            const SizedBox(height: 22),
            buildAllReportListHeader,
            const SizedBox(height: 22),
            buildReportList(),
          ],
        ),
      );

  Widget buildAllNames() {
    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Container(
          height: 62,
          width: 62,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.primaryColor,
          ),
          alignment: Alignment.center,
          child: const Text(
            'Jane',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Palette.lightBgColor,
            ),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 17),
        itemCount: 4,
      ),
    );
  }

  Widget get buildAllReportListHeader {
    return Row(
      children: [
        const Text(
          'All Reports',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.primaryColor,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: openDrawer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Assets.ic_filter),
          ),
        ),
      ],
    );
  }

  Widget buildReportList() {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (_, index) => const ReportTile(),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  @override
  Widget? get drawer => const ReportFilter();
}
