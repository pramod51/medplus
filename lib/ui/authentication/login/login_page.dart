import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/authentication/login/login_page_controller.dart';
import 'package:medplus/ui/base/simple_scaffold.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/input_form_field.dart';

class LoginPage extends SimpleScaffold {
  static const routeName = "/login";
  static void start() {
    Get.offAllNamed(routeName);
  }

  LoginPage({Key? key}) : super(key: key);
  final controller = Get.find<LoginPageController>();
  @override
  Widget get buildBody {
    return Column(
      children: [
        Container(
          height: 64,
          color: Palette.buttonColor,
        ),
        buildMiddleImage,
        Text(
          'login_now'.tr,
          style: const TextStyle(
            fontSize: 24,
            height: 29 / 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'login_desc'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 24 / 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: InputFormField(
            controller: controller.phoneTextEditingController,
            hint: 'mob_num'.tr,
            fontSize: 13,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9+ ]')),
            ],
            textColor: Colors.white.withOpacity(0.7),
            outlineColor: Colors.white.withOpacity(0.7),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
          ),
        ),
        const SizedBox(height: 22),
        AppElevatedBtn(
          onPressed: controller.onLoginClicked,
          borderRadius: 10,
          text: 'request_otp'.tr,
          color: Palette.lightBgColor,
          textColor: Palette.textColor,
        ),
        const SizedBox(height: 51),
        Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                )),
              ),
            ),
            const SizedBox(width: 18),
            const Text(
              'Or Continue with',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                )),
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
        const SizedBox(height: 49),
        Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: AppElevatedBtn(
                onPressed: controller.onGoogleSIgneInClicked,
                borderRadius: 5,
                icon: SvgPicture.asset(Assets.ic_google),
                text: 'google_sign_in'.tr,
                color: Colors.white.withOpacity(0.8),
                textColor: Palette.textColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppElevatedBtn(
                onPressed: controller.loginWithFacebook,
                borderRadius: 5,
                icon: Image.asset(
                  Assets.ic_fb,
                  height: 20,
                ),
                text: 'login_with_facebook'.tr,
                color: Colors.white.withOpacity(0.8),
                textColor: Palette.textColor,
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget get buildMiddleImage {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Image.asset(
                Assets.img_login_bg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: AspectRatio(
          //     aspectRatio: 416 / 117,
          //     child: SvgPicture.asset(
          //       Assets.ic_login_header,
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 2,
              color: Palette.buttonColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 417 / 116,
              child: SvgPicture.asset(
                Assets.ic_login_footer,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
