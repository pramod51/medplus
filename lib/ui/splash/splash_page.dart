import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/ui/base/simple_scaffold.dart';

import 'splash_controller.dart';

class SplashPage extends SimpleScaffold {
  static const routeName = "/start";
  static void start() {
    Get.offAndToNamed(routeName);
  }

  SplashPage({Key? key}) : super(key: key);

  final controller = Get.find<SplashController>();

  @override
  Widget get buildBody => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 95),
          Expanded(
            flex: 536,
            child: SvgPicture.asset(
              Assets.ic_landing_bg,
              fit: BoxFit.fill,
            ),
          ),
          const Spacer(flex: 47),
          SvgPicture.asset(Assets.ic_medplus),
          Text(
            'upload_your_documents_now'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(flex: 108),
        ],
      );
}
