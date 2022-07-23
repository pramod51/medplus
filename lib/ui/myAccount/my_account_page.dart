import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/myAccount/my_account_page_controller.dart';
import 'package:medplus/widgets/app_button.dart';

class MyAccountPage extends AppPage {
  static const routeName = "/myAccount";
  final controller = Get.put(MyAccountPageController());

  MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All My Members ',
              style: TextStyle(
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
            const Center(child: AppElevatedBtn(text: '+ Add Member')),
            const SizedBox(height: 24),
          ],
        ),
      );

  Widget buildMemberList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Container(
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05),
                blurRadius: 5,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: buildMember(),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  Widget buildMember() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        const Text(
          'Jane Cooper (Self)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.textColor,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          height: 0,
          color: Palette.lightBgColor,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Self/ 37 / Male',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Palette.textColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(Assets.ic_edit)
          ],
        )
      ],
    );
  }
}
