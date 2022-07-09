import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/reportListing/report_filter.dart';
import 'package:medplus/ui/reportListing/report_listing_page_controller.dart';
import 'package:medplus/widgets/report_tile.dart';

class ReportListing extends AppPage {
  ReportListing({Key? key}) : super(key: key);
  static const routeName = "/report_listing";
  final controller = Get.find<ReportListingPageController>();

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
            const SizedBox(height: 30),
            buildAllReportListHeader,
            const SizedBox(height: 22),
            buildReportList(),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget buildAllNames() {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => Container(
          height: 76,
          width: 73,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Palette.primaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: const Text(
            'Jane',
            maxLines: 1,
            style: TextStyle(
              fontSize: 15,
              overflow: TextOverflow.clip,
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
            color: Palette.textColor,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: openDrawer,
          child: SvgPicture.asset(Assets.ic_filter),
        ),
      ],
    );
  }

  Widget buildReportList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (_, index) => const ReportTile(),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  @override
  Widget? get drawer => const ReportFilter();
}
