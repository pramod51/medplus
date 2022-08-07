import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/edit_profile/edit_profile_controller.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/radio_button.dart';

class EditProfile extends AppPage {
  static const routeName = "/editProfile";
  EditProfile({Key? key}) : super(key: key);
  final controller = Get.put(EditProfileController());
  @override
  Widget get appBar => const SizedBox.shrink();
  @override
  Widget get body {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'update_profile'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 23),
              InputFormField(
                controller: controller.nameTextEditingController,
                hint: 'name_req'.tr,
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: controller.emailTextEditingController,
                hint: 'email_req'.tr,
                enabled: SharedConfig.email != null,
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: controller.phoneTextEditingController,
                hint: 'mobile_number_req'.tr,
                enabled: SharedConfig.phone != null,
              ),
              const SizedBox(height: 25),
              // buildRadioBtn,
              // const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppElevatedBtn(
                    onPressed: controller.updateDeatils,
                    text: 'update_now'.tr,
                    textColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget get buildRadioBtn {
    return Obx(
      () => Row(
        children: [
          AppRadioButton(
            value: controller.isMale.value,
            label: 'male'.tr,
            onTap: controller.onGenderChanged,
          ),
          const SizedBox(width: 20),
          AppRadioButton(
            value: !controller.isMale.value,
            label: 'female'.tr,
            onTap: controller.onGenderChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget get bottomNavigationBar => const SizedBox.shrink();
}
