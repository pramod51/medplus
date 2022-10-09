import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/myAccount/my_account_page_controller.dart';
import 'package:medplus/widgets/api_response_widget.dart';
import 'package:medplus/widgets/app_button.dart';

class MyAccountPage extends AppPage {
  static const routeName = "/myAccount";
  final controller = Get.put(MyAccountPageController());

  MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget get body {
    return Obx(
      () {
        if (controller.apiTuple.value.item1 == ApiStatus.SUCCESS) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'all_my_members'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Palette.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Deserunt ullamco est sit aliqua dolor do amet sint.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Palette.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  height: 0,
                  color: Palette.darkBg,
                ),
                const SizedBox(height: 16),
                buildMemberList(),
                const SizedBox(height: 24),
                Center(
                    child: AppElevatedBtn(
                  text: 'add_new_member'.tr,
                  onPressed: controller.onAddMemberClicked,
                )),
                const SizedBox(height: 24),
              ],
            ),
          );
        } else if (controller.apiTuple.value.item1 == ApiStatus.SERVER_ERROR) {
          return ErrorScreen(
            onTryAgain: controller.fetchFamily,
          );
        }
        return loadingScreen;
      },
    );
  }

  Widget buildMemberList() {
    return Obx(() {
      final list = controller.familyList.where((p0) => p0.id != null).toList();
      if (list.isEmpty) {
        return SizedBox(
          height: 100,
          child: NoDataScreen(
            message: 'no_member_found'.tr,
          ),
        );
      }
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final data = list[index];
          return Container(
            height: 76,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Palette.borderColor)),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: buildMember(data),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      );
    });
  }

  Widget buildMember(FamilyData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        Text(
          data.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textColor,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          thickness: 1,
          height: 0,
          color: Palette.lightBgColor,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                '${data.relation}/${data.sex}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Palette.textColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
                onTap: () => controller.onAddMemberClicked(
                    familyId: data.id?.toString() ?? '',
                    name: data.name,
                    relation: data.relation,
                    isMale: data.sex.toLowerCase() == 'male'),
                child: SvgPicture.asset(Assets.ic_edit))
          ],
        )
      ],
    );
  }
}
