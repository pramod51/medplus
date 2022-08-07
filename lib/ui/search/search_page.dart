import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/search/search_page_controller.dart';
import 'package:medplus/widgets/api_response_widget.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/report_tile.dart';
import 'package:medplus/widgets/simple_chip.dart';

class SearchPage extends AppPage {
  final controller = Get.put(SearchPageController());

  static const routeName = "/search";
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget get body {
    return Obx(
      () {
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
                if (controller.apiTupal.value.item1 == ApiStatus.SUCCESS) ...[
                  ...buildAllResults(),
                ] else if (controller.apiTupal.value.item1 ==
                    ApiStatus.LOADING) ...[
                  Center(child: loadingScreen)
                ] else if (controller.apiTupal.value.item1 ==
                    ApiStatus.SERVER_ERROR) ...[
                  Center(
                    child: ErrorScreen(
                      onTryAgain: controller.search,
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      },
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
      controller: controller.textEditingController,
      prefixIcon: SvgPicture.asset(
        Assets.ic_search,
        height: 20,
        width: 20,
      ),
      hint: 'enter_keyword'.tr,
      fillColor: Colors.white,
    );
  }

  List<Widget> buildSuggestions() {
    final list = SharedConfig.subCategory ?? <String>[];
    if (list.isEmpty) return [const SizedBox.shrink()];
    return [
      Text(
        'suggestions'.tr,
        style: const TextStyle(
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
          for (int i = 0; i < list.length; i++) ...[
            SimpleChip(
              text: list[i],
              onClick: (bool val) {
                if (val) {
                  controller.suggestions.add(list[i]);
                } else {
                  controller.suggestions
                      .removeWhere((element) => element == list[i]);
                }
                controller.textEditingController.text =
                    controller.suggestions.join(' ');
              },
            ),
          ]
        ],
      ),
    ];
  }

  List<Widget> buildAllResults() {
    return [
      Text(
        'all_results'.tr,
        style: const TextStyle(
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
      if (controller.data.isEmpty) ...[
        SizedBox(
          height: 100,
          child: NoDataScreen(
            message: 'no_result_found'.tr,
          ),
        ),
      ] else ...[
        Obx(
          () => SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final data = controller.data[index];
                return ReportTile(
                  data: data,
                  userName: controller.familyNameMap[data.familyId] ??
                      SharedConfig.name ??
                      '',
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: controller.data.length,
            ),
          ),
        ),
      ]
    ];
  }
}
