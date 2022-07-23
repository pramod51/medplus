import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medplus/res/assets.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/widgets/app_button.dart';
import 'package:medplus/widgets/input_form_field.dart';

class AddMemberDilog extends StatelessWidget {
  const AddMemberDilog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Add Family Member',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Amet minim mollit non deserunt ullamco ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Palette.textColor,
                ),
              ),
              const SizedBox(height: 23),
              InputFormField(
                controller: TextEditingController(),
                hint: 'Name*',
              ),
              const SizedBox(height: 18),
              InputFormField(
                controller: TextEditingController(),
                hint: 'Relation*',
              ),
              const SizedBox(height: 25),
              buildRadioBtn,
              const SizedBox(height: 28),
              buildActionButton,
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget get buildCloseButton => Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: IconButton(
              onPressed: (() => Get.back()),
              icon: SvgPicture.asset(Assets.ic_close),
              splashRadius: 20,
            ),
          ),
          const SizedBox(width: 4),
        ],
      );

  Widget get buildRadioBtn {
    return Row();
  }

  Widget get buildActionButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14,
                color: Palette.textColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        AppElevatedBtn(
          onPressed: () {},
          text: '+ Add Member',
          textColor: Colors.white,
        ),
      ],
    );
  }
}
