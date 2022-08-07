import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/authentication/otp/otp_page_controller.dart';
import 'package:medplus/ui/base/simple_scaffold.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends SimpleScaffold {
  OtpPage({Key? key}) : super(key: key);
  static const routeName = "/otp";
  static void start(dynamic args) {
    Get.toNamed(
      routeName,
      arguments: args,
    );
  }

  final controller = Get.find<OtpPageController>();

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'otp_desc'.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          height: 3 / 2,
          color: Colors.white,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget get buildOtpView {
    return SizedBox(
      width: 220,
      height: 40,
      child: PinFieldAutoFill(
        onCodeSubmitted: controller.onCodeSubmitted,
        controller: controller.pinFieldAutoFillController,
        codeLength: 4,
        decoration: BoxLooseDecoration(
          strokeColorBuilder: const FixedColorBuilder(Colors.white),
          textStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Montserrat',
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget get buildSubmitBtn {
    return AppElevatedBtn(
      width: 150,
      onPressed: controller.onSubmitClicked,
      borderRadius: 245,
      text: 'submit'.tr,
      color: Palette.lightBgColor,
      textColor: Palette.textColor,
    );
  }
}
