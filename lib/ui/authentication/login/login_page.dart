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
        const Text(
          'Login Now',
          style: TextStyle(
            fontSize: 24,
            height: 29 / 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Please enter details below to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
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
            hint: 'Mobile Number',
            fontSize: 13,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            textColor: Colors.white.withOpacity(0.7),
            outlineColor: Colors.white.withOpacity(0.7),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
          ),
        ),
        const SizedBox(height: 24),
        AppElevatedBtn(
          onPressed: controller.onLoginClicked,
          width: 189,
          borderRadius: 245,
          text: 'Request OTP',
          color: Palette.lightBgColor,
          textColor: Palette.textColor,
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
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: 416 / 117,
              child: SvgPicture.asset(
                Assets.ic_login_header,
                fit: BoxFit.fill,
              ),
            ),
          ),
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
