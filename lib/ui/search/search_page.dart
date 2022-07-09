import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/search/serach_page_controller.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/report_tile.dart';
import 'package:medplus/widgets/simple_chip.dart';

class SearchPage extends AppPage {
  final controller = Get.find<SearchPageController>();

  static const routeName = "/search";
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget get body {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBox,
            const SizedBox(height: 18),
            ...buildSuggestions(),
            const SizedBox(height: 19),
            ...buildAllResults(),
          ],
        ),
      ),
    );
  }

  @override
  Widget get buildCloseButton {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () {
            //_controller.onSeachDilogClosesd();
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SvgPicture.asset(
              Assets.ic_close,
            ),
          ),
        ),
      ],
    );
  }

  Widget get buildSearchBox {
    return InputFormField(
      controller: TextEditingController(),
      prefixIcon: SvgPicture.asset(
        Assets.ic_search,
        height: 20,
        width: 20,
      ),
      hint: 'Enter keyword',
      fillColor: Colors.white,
    );
  }

  List<Widget> buildSuggestions() {
    return [
      const Text(
        'Suggestions',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (int i = 0; i < 10; i++) ...[
            const SimpleChip(text: 'text'),
          ]
        ],
      ),
    ];
  }

  List<Widget> buildAllResults() {
    return [
      const Text(
        'All Results',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Palette.textColor,
        ),
      ),
      const SizedBox(height: 6),
      const Divider(
        height: 0,
        color: Palette.darkBg,
      ),
      const SizedBox(height: 19),
      SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return const ReportTile();
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: 10,
        ),
      ),
    ];
  }
}
