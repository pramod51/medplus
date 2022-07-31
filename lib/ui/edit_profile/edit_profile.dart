import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/ui/base/app_page.dart';
import 'package:medplus/ui/edit_profile/edit_profile_controller.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/input_form_field.dart';
import 'package:medplus/widgets/radio_button.dart';

class EditProfile extends AppPage {
  EditProfile({Key? key}) : super(key: key);
  final controller = Get.put(EditProfileController());
  @override
  Widget get body {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildCloseButton,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 23),
              InputFormField(
                controller: controller.nameTextEditingController,
                hint: 'Name*',
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: controller.nameTextEditingController,
                hint: 'Email*',
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: controller.phoneTextEditingController,
                hint: 'Mobile Number*',
              ),
              const SizedBox(height: 25),
              buildRadioBtn,
              const SizedBox(height: 28),
              AppElevatedBtn(
                onPressed: controller.updateDeatils,
                text: 'Update Now',
                textColor: Colors.white,
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
            label: 'Male',
            onTap: controller.onGenderChanged,
          ),
          const SizedBox(width: 20),
          AppRadioButton(
            value: !controller.isMale.value,
            label: 'Female',
            onTap: controller.onGenderChanged,
          ),
        ],
      ),
    );
  }
}
