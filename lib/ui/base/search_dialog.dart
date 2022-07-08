import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/report_tile.dart';
import 'package:medplus/widgets/simple_chip.dart';

class SearchDialog extends StatelessWidget {
  final _controller = Get.find<AppPageController>();
  SearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCloseButton,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearchBox,
                const SizedBox(height: 18),
                ...buildSuggestions(),
                const SizedBox(height: 20),
                ...buildAllResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get buildCloseButton {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () {
            _controller.onSeachDilogClosesd();
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
    );
  }

  List<Widget> buildSuggestions() {
    return [
      const Text(
        'Suggestions',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Palette.textLight,
        ),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (int i = 0; i < 10; i++) ...[const SimpleChip(text: 'text')]
        ],
      ),
    ];
  }

  List<Widget> buildAllResults() {
    return [
      const Text(
        'All Results',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Palette.primaryColor,
        ),
      ),
      const SizedBox(height: 8),
      const Divider(
        height: 0,
        color: Palette.darkBg,
      ),
      const SizedBox(height: 19),
      SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return const ReportTile();
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: 50,
        ),
      ),
    ];
  }
}
