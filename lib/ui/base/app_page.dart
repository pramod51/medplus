import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class AppPage extends StatelessWidget {
  AppPage({Key? key}) : super(key: key);
  final _controller = Get.put(AppPageController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: drawer,
        endDrawer: endDrawer,
        backgroundColor: Palette.lightBlueBg,
        body: scaffoldBody,
      ),
    );
  }

  Widget get scaffoldBody => Column(
        children: [
          const SizedBox(height: 30),
          appBar,
          SizedBox(height: profilePlaceHolder == null ? 30 : 0),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(Get.context!)
                  .copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: body,
              ),
            ),
          ),
        ],
      );

  Widget get body => Container();

  Widget get appBar => Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            if (profilePlaceHolder == null) ...[
              buildProfileImage,
              const SizedBox(width: 12),
              Expanded(
                child: buildName,
              ),
            ] else ...[
              profilePlaceHolder ?? const SizedBox.shrink(),
              const Spacer(),
            ],
            GestureDetector(
              onTap: () => openEndDrawer(),
              child: SvgPicture.asset(Assets.ic_burger_menu),
            ),
          ],
        ),
      );

  Widget get buildName {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.secondaryColor,
          ),
        ),
        Text(
          'Jane Cooper',
          style: TextStyle(
            fontSize: 20,
            height: 25 / 20,
            fontWeight: FontWeight.w700,
            color: Palette.textColor,
          ),
        ),
      ],
    );
  }

  Widget get buildProfileImage {
    return SizedBox(
      height: 48,
      width: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: const CircleAvatar(),
      ),
    );
  }

  Widget? get drawer => null;

  Widget get endDrawer => Drawer(
        width: 224,
        child: Column(
          children: [
            buildCloseButton,
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_my_account,
              name: 'My Account',
              ontap: _controller.onMyAccountClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_doc,
              name: 'All Reports',
              ontap: _controller.onAllReportsClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_add_member,
              name: 'Add Member',
              ontap: _controller.onAddMemberClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_my_members,
              name: 'My Members',
              ontap: _controller.onMyMemberClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_language,
              name: 'Language',
              ontap: _controller.onLanguageClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_refer_a_frd,
              name: 'Refer a Friend',
              ontap: _controller.onRefAFrdClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_sign_out,
              name: 'Sign Out',
              ontap: _controller.onSignOutClicked,
            ),
            buildDivider,
          ],
        ),
      );

  Widget get buildDivider => const Divider(
        color: Palette.americanSilver,
        height: 1,
      );

  Widget get buildCloseButton => Row(
        children: [
          const Spacer(),
          GestureDetector(
            onTap: closeEndDrawer,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SvgPicture.asset(Assets.ic_close),
            ),
          ),
        ],
      );

  Widget buildDrawarItem({
    required String assets,
    required String name,
    required VoidCallback ontap,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
        closeEndDrawer();
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 14),
            SvgPicture.asset(assets),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  color: Palette.jacarta,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  void closeEndDrawer() {
    _scaffoldKey.currentState?.closeEndDrawer();
  }

  Widget? get profilePlaceHolder => null;
}
