import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/home/home_page_controller.dart';
import 'package:medplus/widgets/api_response_widget.dart';
import 'package:medplus/widgets/app_network_image.dart';
import 'package:medplus/widgets/app_tab_bar.dart';
import 'package:medplus/widgets/report_tile.dart';

class HomePage extends AppPage {
  static const routeName = "/home";
  final controller = Get.put(HomePageController());
  static void start() {
    Get.offAllNamed(routeName);
  }

  HomePage({Key? key}) : super(key: key);

  @override
  Widget get body {
    return Obx(() {
      if (controller.apiTupal.value.item1 == ApiStatus.SUCCESS) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 7),
            buildTabsRow,
            const SizedBox(height: 13),
            buildGrid(),
            const SizedBox(height: 56),
            buildYourReport(),
            const SizedBox(height: 26),
          ],
        );
      } else if (controller.apiTupal.value.item1 == ApiStatus.SERVER_ERROR) {
        return ErrorScreen(
          onTryAgain: controller.fetchData,
        );
      }
      return loadingScreen;
    });
  }

  @override
  List<Widget> get leadingAppBar {
    return [
      Obx(() {
        return controller.apiTupal.value.item1 == ApiStatus.SUCCESS
            ? buildProfileImage
            : const Spacer();
      }),
      const SizedBox(width: 12),
      Obx(() {
        return controller.apiTupal.value.item1 == ApiStatus.SUCCESS
            ? Expanded(child: buildName)
            : const SizedBox.shrink();
      }),
    ];
  }

  Widget get buildName {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.secondaryColor,
          ),
        ),
        Text(
          controller.homePageData!.user.name,
          style: const TextStyle(
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AppNetworkImage(
        width: 48,
        height: 48,
        initChar: initChar(controller.homePageData!.user.name),
        url: controller.homePageData!.user.profilePhotoUrl,
      ),
    );
  }

  String initChar(String? val) {
    if (val == null || val.isEmpty) {
      return '';
    }
    return val[0];
  }

  Widget get buildTabsRow {
    return Row(
      children: [
        const SizedBox(width: 24),
        Expanded(child: buildTabBar),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () => controller.onAddMemberClicked(),
          child: const Text(
            '+ Add Member',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Palette.textColor,
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget get buildTabBar {
    if (controller.homePageData == null) {
      return const SizedBox(
        height: 50,
      );
    }

    return Obx(() {
      final list = controller.homePageData!.myFamily;

      return AppTabBarPlain(
        initialTabIndex: controller.selectedTabIndex,
        height: 33,
        tabs: [
          Tab(
            child: Text(controller.homePageData!.user.name),
          ),
          for (FamilyData data in list) ...[
            Tab(
              child: Text(data.name),
            ),
          ]
        ],
        onTabClicked: (int index) {
          controller.selectedTabIndex = index;
          if (index == 0) {
            controller.name = controller.homePageData!.user.name;
          }
          controller.onTabClicked(
              index == 0 ? FamilyData.fromMap({}) : list[index - 1]);
        },
      );
    });
  }

  Widget buildGrid() {
    final data = controller.homePageData!.category;

    return pad(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.homePageData!.category.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 24,
          crossAxisCount: 2,
          mainAxisExtent: 124,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => controller
                .onCategoryClicked(controller.homePageData!.category[index]),
            child: Container(
              height: 124,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: data[index].color,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Assets.ic_stethoscope,
                      color: data[index].color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildYourReport() {
    return pad(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Your Reports',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Palette.secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          if (controller.homePageData!.yourReport.isEmpty) ...[
            const SizedBox(
              height: 100,
              child: NoDataScreen(
                message: 'No report found',
              ),
            ),
          ] else ...[
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.homePageData!.yourReport.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ReportTile(
                    userName: controller.homePageData!.user.name,
                    data: controller.homePageData!.yourReport[index]);
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 10,
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget pad({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }
}
