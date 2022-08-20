import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/reportListing/report_listing_page_controller.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/app_check_box.dart';
import 'package:medplus/widgets/input_form_field.dart';

class ReportFilter extends StatelessWidget {
  final List<Category> category;
  final Function(String selectedCat, bool isSelected) onCategorySelected;
  final SortFilter sortFilter;
  final Function(SortFilter) onSortFilterChanged;
  final VoidCallback onFilterApplied;
  final VoidCallback onFilterRemoved;

  const ReportFilter({
    Key? key,
    required this.category,
    required this.onCategorySelected,
    required this.sortFilter,
    required this.onSortFilterChanged,
    required this.onFilterApplied,
    required this.onFilterRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            buildCloseBtn,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // buildSearchBox,
                  // const Divider(
                  //   height: 0,
                  //   color: Palette.platinum,
                  // ),
                  const SizedBox(height: 25),
                  ...buildCategoryFilter,
                  const SizedBox(height: 26),
                  ...buildSortingFilter,
                  const SizedBox(height: 40),
                  buildApplyClearBtn,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get buildCloseBtn {
    return Row(
      children: [
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: SvgPicture.asset(Assets.ic_close),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget get buildSearchBox {
    return InputFormField(
      hint: 'search'.tr,
      prefixIcon: SvgPicture.asset(Assets.ic_search),
      controller: TextEditingController(),
      fillColor: Palette.lightBlueBg,
    );
  }

  List<Widget> get buildCategoryFilter {
    return [
      Text(
        'category'.tr,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 13),
      ListView.separated(
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: (_, index) {
          return Obx(
            () => AppCheckBox(
              filled: category[index].isSelected.value,
              label: category[index].name,
              onTap: (val) {
                category[index].isSelected.value = val;
                onCategorySelected(category[index].name, val);
              },
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
    ];
  }

  List<Widget> get buildSortingFilter {
    return [
      Text(
        'sorting'.tr,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 23),
      AppCheckBox(
        filled: sortFilter == SortFilter.latest,
        label: 'latest'.tr,
        onTap: (val) {
          if (sortFilter == SortFilter.latest) {
            onSortFilterChanged(SortFilter.none);
            return;
          }
          onSortFilterChanged(SortFilter.latest);
        },
      ),
      const SizedBox(height: 10),
      AppCheckBox(
        filled: sortFilter == SortFilter.old,
        label: 'old'.tr,
        onTap: (val) {
          if (sortFilter == SortFilter.old) {
            onSortFilterChanged(SortFilter.none);
            return;
          }
          onSortFilterChanged(SortFilter.old);
        },
      ),
    ];
  }

  Widget get buildApplyClearBtn {
    return Row(
      children: [
        Expanded(
          flex: 139,
          child: AppElevatedBtn(
            text: 'apply'.tr,
            onPressed: onFilterApplied,
          ),
        ),
        const SizedBox(width: 19),
        Expanded(
          flex: 90,
          child: AppOutlinedBtn(
            text: 'clear'.tr,
            onPressed: onFilterRemoved,
          ),
        )
      ],
    );
  }
}
