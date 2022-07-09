import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/app_check_box.dart';
import 'package:medplus/widgets/input_form_field.dart';

class ReportFilter extends StatelessWidget {
  const ReportFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildCloseBtn,
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchBox,
                  const SizedBox(height: 27),
                  const Divider(
                    height: 0,
                    color: Palette.platinum,
                  ),
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
      hint: 'Search',
      prefixIcon: SvgPicture.asset(Assets.ic_search),
      controller: TextEditingController(),
      fillColor: Palette.lightBlueBg,
    );
  }

  List<Widget> get buildCategoryFilter {
    return [
      const Text(
        'Category',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 13),
      const AppCheckBox(
        filled: false,
        label: 'Pathology',
      ),
      const SizedBox(height: 10),
      const AppCheckBox(
        filled: false,
        label: 'Radiology',
      ),
      const SizedBox(height: 10),
      const AppCheckBox(
        filled: false,
        label: 'Surgery',
      ),
      const SizedBox(height: 10),
      const AppCheckBox(
        filled: false,
        label: 'Bills/Receipts',
      ),
    ];
  }

  List<Widget> get buildSortingFilter {
    return [
      const Text(
        'Sorting',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 23),
      const AppCheckBox(
        filled: false,
        label: 'Latest',
      ),
      const SizedBox(height: 10),
      const AppCheckBox(
        filled: false,
        label: 'Old',
      ),
      const SizedBox(height: 10),
      const AppCheckBox(
        filled: false,
        label: 'Size',
      ),
    ];
  }

  Widget get buildApplyClearBtn {
    return Row(
      children: const [
        Expanded(
          flex: 139,
          child: AppElevatedBtn(
            text: 'Apply',
          ),
        ),
        SizedBox(width: 19),
        Expanded(
          flex: 90,
          child: AppOutlinedBtn(
            text: 'Clear',
          ),
        )
      ],
    );
  }
}
