import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class AppPage extends StatelessWidget {
  AppPage({Key? key}) : super(key: key);
  final _controller = Get.put(AppPageController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _controller.selectedBottomNav.value = BottomNavItems.home;
          return true;
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          backgroundColor: Colors.white,
          body: scaffoldBody,
        ));
  }

  Widget get loadingScreen {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 150,
        ),
        CircularProgressIndicator.adaptive(),
      ],
    );
  }

  Widget get bottomNavigationBar {
    return Theme(
      data: Get.theme.copyWith(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Container(
        height: Platform.isIOS ? 125 : 95,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Obx(
          () => BottomNavigationBar(
            elevation: 0,
            iconSize: 30,
            onTap: _controller.onTap,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              bottomNavigationBarItem(
                assetsPath: Assets.ic_home,
                isSelected:
                    _controller.selectedBottomNav.value == BottomNavItems.home,
              ),
              bottomNavigationBarItem(
                assetsPath: Assets.ic_search_32,
                isSelected: _controller.selectedBottomNav.value ==
                    BottomNavItems.search,
              ),
              bottomNavigationBarItem(
                assetsPath: Assets.ic_doc,
                isSelected: _controller.selectedBottomNav.value ==
                    BottomNavItems.reports,
              ),
              bottomNavigationBarItem(
                assetsPath: Assets.ic_my_account,
                isSelected: _controller.selectedBottomNav.value ==
                    BottomNavItems.myAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem({
    required String assetsPath,
    bool isSelected = false,
  }) {
    return BottomNavigationBarItem(
      label: '',
      backgroundColor: Colors.transparent,
      icon: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: !isSelected ? Palette.primaryColor : Colors.white,
            shape: BoxShape.circle),
        child: SvgPicture.asset(
          assetsPath,
          color: !isSelected ? Colors.white : Palette.primaryColor,
        ),
      ),
    );
  }

  Widget get scaffoldBody {
    return Column(
      children: [
        const SizedBox(height: 70),
        appBar,
        SizedBox(height: leadingAppBar.isNotEmpty ? 30 : 20),
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(Get.context!)
                .copyWith(scrollbars: false),
            child: nonScroableBody ??
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: body,
                ),
          ),
        ),
      ],
    );
  }

  Widget get body => Container();

  Widget? get nonScroableBody => null;

  Widget get appBar => SizedBox(
        height: 48,
        child: Row(
          children: [
            if (leadingAppBar.isEmpty) ...[
              const SizedBox(width: 12),
              buildBackButton,
              const Spacer(),
            ] else ...[
              const SizedBox(width: 24),
              ...leadingAppBar,
            ],
            GestureDetector(
              onTap: () => openEndDrawer(),
              child: SvgPicture.asset(Assets.ic_burger_menu),
            ),
            const SizedBox(width: 24),
          ],
        ),
      );

  List<Widget> get leadingAppBar => [];

  Widget get buildBackButton => IconButton(
        onPressed: () => _controller.onBackButtonClicked(),
        icon: RotatedBox(
          quarterTurns: SharedConfig.textDirection == TextDirection.rtl ? 2 : 0,
          child: SvgPicture.asset(
            Assets.ic_arrow_right,
          ),
        ),
        splashRadius: 20,
      );

  Widget? get drawer => null;

  Widget get endDrawer => Drawer(
        width: 224,
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildCloseButton,
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_my_account,
              name: 'my_account'.tr,
              ontap: _controller.onMyAccountClicked,
              color: Palette.textColor,
              width: 24,
              height: 24,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_doc,
              name: 'all_reports'.tr,
              ontap: _controller.onAllReportsClicked,
              color: Palette.textColor,
              width: 24,
              height: 24,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_add_member,
              name: 'add_member'.tr,
              ontap: _controller.onAddMemberClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_my_members,
              name: 'my_members'.tr,
              ontap: _controller.onMyMemberClicked,
            ),
            buildDivider,
            buildDrawarItem(
              autoClose: false,
              assets: Assets.ic_language,
              name: 'change_to'.tr +
                  (SharedConfig.locale.first == 'en' ? 'AR' : "EN"),
              ontap: _controller.onLanguageClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_refer_a_frd,
              name: 'refer_a_friend'.tr,
              ontap: _controller.onRefAFrdClicked,
            ),
            buildDivider,
            buildDrawarItem(
              assets: Assets.ic_sign_out,
              name: 'sign_out'.tr,
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: closeEndDrawer,
              icon: SvgPicture.asset(Assets.ic_close),
              splashRadius: 24,
            ),
          ),
        ],
      );

  Widget buildDrawarItem({
    required String assets,
    required String name,
    required VoidCallback ontap,
    Color? color,
    double? width,
    double? height,
    bool autoClose = true,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
        if (autoClose) {
          closeEndDrawer();
        }
      },
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 14),
            SvgPicture.asset(
              assets,
              color: color,
              width: width,
              height: height,
            ),
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
}
