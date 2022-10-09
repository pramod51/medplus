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
  @override
  Widget get nonScroableBody {
    return Obx(
      () {
        if (controller.apiTuple.value.item1 == ApiStatus.SUCCESS) {
          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    buildAllNames(),
                    buildAllReportListHeader,
                    const SizedBox(height: 22),
                    buildReportList(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        } else if (controller.apiTuple.value.item1 == ApiStatus.SERVER_ERROR ||
            controller.apiTuple.value.item1 == ApiStatus.NO_DATA) {
          return ErrorScreen(
            message: controller.apiTuple.value.item2,
            onTryAgain: controller.fetchFamilyReport,
          );
        }
        return loadingScreen;
      },
    );
  }

  Widget buildAllNames() {
    if (controller.familyList.isEmpty) {
      return SizedBox(
        height: 100,
        child: NoDataScreen(
          message: 'no_family_found'.tr,
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 140,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Obx(() {
            final data = controller.familyList
                .where((p0) => p0.id != null)
                .toList()[index];
            return Row(
              children: [
                SizedBox(
                  height: 76,
                  child: GestureDetector(
                    onTap: () => controller.onFamilySelected(index),
                    child: Container(
                      width: 73,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index == controller.selectedIndex.value
                              ? Palette.primaryColor
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff666666).withOpacity(0.20),
                              blurRadius: 40,
                            )
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: Text(
                        data.name,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: index == controller.selectedIndex.value
                              ? Palette.lightBgColor
                              : Palette.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        },
        separatorBuilder: (_, __) => const SizedBox(width: 17),
        itemCount: controller.familyList.where((p0) => p0.id != null).length,
      ),
    );
  }

  Widget get buildAllReportListHeader {
    return Row(
      children: [
        Text(
          'all_reports'.tr,
          style: const TextStyle(
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
    if (controller.reportApiTuple.value.item1 == ApiStatus.SUCCESS) {
      if (controller.familyList.isEmpty) {
        return const SizedBox.shrink();
      }
      if (controller.data.isEmpty) {
        return SizedBox(
          height: 100,
          child: NoDataScreen(
            message: 'no_report_found'.tr,
          ),
        );
      }

      return Obx(
        () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.data.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => ReportTile(
            userName:
                controller.familyList[controller.selectedIndex.value].name,
            data: controller.data[index],
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
        ),
      );
    } else if (controller.apiTuple.value.item1 == ApiStatus.SERVER_ERROR) {
      return ErrorScreen(
        onTryAgain: controller.fetchFamilyReport,
      );
    }

    return loadingScreen;
  }

  @override
  Widget? get drawer => Obx(
        () => ReportFilter(
          category: controller.category,
          onCategorySelected: (String selectedCat, bool isSelected) {},
          onSortFilterChanged: controller.onSortChanges,
          sortFilter: controller.sorting.value,
          onFilterApplied: controller.categoryFilter,
          onFilterRemoved: controller.onFilterRemoved,
        ),
      );
}
