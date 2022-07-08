import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/simple_scaffold.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/input_form_field.dart';

class OtpPage extends SimpleScaffold {
  const OtpPage({Key? key}) : super(key: key);
  static const routeName = "/otp";
  static void start() {
    Get.toNamed(routeName);
  }

  @override
  Widget get buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 64,
          color: Palette.buttonColor,
        ),
        buildMiddleImage,
        const SizedBox(height: 15),
        buildOtpDesc,
        const SizedBox(height: 26),
        buildOtpView,
        const SizedBox(height: 30),
        buildSubmitBtn,
        const SizedBox(height: 47),
      ],
    );
  }

  Widget get buildMiddleImage {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.asset(
                Assets.img_otp_bg,
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

  Widget get buildOtpDesc {
    return const Text(
      'Enter 4 digit verification code sent to your number',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        height: 3 / 2,
        color: Colors.white,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget get buildOtpView {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 6; i++)
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: InputFormField(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              controller: TextEditingController(),
              textAlign: TextAlign.center,
              fontSize: 13,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              textColor: Colors.white.withOpacity(0.7),
              outlineColor: Colors.white.withOpacity(0.7),
            ),
          )
      ],
    );
  }

  Widget get buildSubmitBtn {
    return AppElevatedBtn(
      width: 150,
      onPressed: () => HomePage.start(),
      borderRadius: 245,
      text: 'Submit',
      color: Palette.lightBgColor,
      textColor: Palette.textColor,
    );
  }
}
