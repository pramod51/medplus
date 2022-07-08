import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';
import 'package:medplus/widgets/input_form_field.dart';

class AddMemberDilog extends StatelessWidget {
  const AddMemberDilog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
                color: Palette.secondaryColor,
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
          ],
        )
      ],
    );
  }

  Widget get buildRadioBtn {
    return Row();
  }
}
