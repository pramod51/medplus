import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/uploadReport/upload_report.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/app_tab_bar.dart';
import 'package:medplus/widgets/report_tile.dart';

class HomePage extends AppPage {
  static const routeName = "/home";
  static void start() {
    Get.toNamed(routeName);
  }

  HomePage({Key? key}) : super(key: key);

  @override
  Widget get body => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 7),
          buildTabBar,
          const SizedBox(height: 13),
          buildGrid(),
          const SizedBox(height: 32),
          buildAddRecButton,
          const SizedBox(height: 56),
          buildYourReport(),
          const SizedBox(height: 26),
        ],
      );

  Widget get buildTabBar {
    return AppTabBarPlain(
      height: 33,
      tabs: const [
        Tab(
          text: 'Jane Cooper',
        ),
        Tab(
          text: 'Jane Cooper',
        ),
        Tab(
          text: 'Test',
        ),
      ],
      onTabClicked: (int tab) {},
    );
  }

  Widget buildGrid() {
    return pad(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 24,
          crossAxisCount: 2,
          mainAxisExtent: 124,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (_, index) {
          return Container(
            height: 124,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Palette.col7166F9,
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
                  child: SvgPicture.asset(Assets.ic_stethoscope),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pathology',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get buildAddRecButton => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppElevatedBtn(
            onPressed: () => UploadReport.start(),
            text: '+ Add Record',
            textColor: Colors.white,
          ),
        ],
      );

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
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return const ReportTile();
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
          )
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
