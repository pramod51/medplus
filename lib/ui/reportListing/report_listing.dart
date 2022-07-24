import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/reportListing/report_filter.dart';
import 'package:medplus/widgets/api_response_widget.dart';
import 'package:medplus/widgets/report_tile.dart';

import 'report_listing_page_controller.dart';

class ReportListing extends AppPage {
  ReportListing({Key? key}) : super(key: key);
  static const routeName = "/report_listing";
  final controller = Get.put(ReportListingPageController());

  static void start() {
    Get.toNamed(routeName);
  }

  @override
  Widget get body {
    return Obx(
      () {
        if (controller.apiTupal.value.item1 == ApiStatus.SUCCESS) {
          return Padding(
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
        } else if (controller.apiTupal.value.item1 == ApiStatus.SERVER_ERROR) {
          return ErrorScreen(
            onTryAgain: controller.fetchFamilyReport,
          );
        }
        return loadingScreen;
      },
    );
  }

  Widget buildAllNames() {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final data = controller.familyList[index];
          return GestureDetector(
            onTap: () => controller.onFamilySelected(index),
            child: Obx(
              () => Container(
                height: 76,
                width: 73,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: data.isSelected ? Palette.primaryColor : Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                child: Text(
                  controller.familyList[index].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: data.isSelected
                        ? Palette.lightBgColor
                        : Palette.textColor,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 17),
        itemCount: controller.familyList.length,
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
    if (controller.reportApiTupal.value.item1 == ApiStatus.SUCCESS) {
      if (controller.familyList.isEmpty) {
        return const SizedBox(
          height: 100,
          child: NoDataScreen(
            message: 'No Report found',
          ),
        );
      }

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.data.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => ReportTile(
          userName: controller.familyList[controller.selectedIndex].name,
          data: controller.data[index],
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      );
    } else if (controller.apiTupal.value.item1 == ApiStatus.SERVER_ERROR) {
      return ErrorScreen(
        onTryAgain: controller.fetchFamilyReport,
      );
    }

    return loadingScreen;
  }

  @override
  Widget? get drawer => const ReportFilter();
}
