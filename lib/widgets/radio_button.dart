import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class RadioButton extends StatelessWidget {
  final bool value;
  const RadioButton({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 20,
      width: 20,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Palette.secondaryColor),
      ),
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 6,
        backgroundColor: value ? Palette.buttonColor : Colors.white,
      ),
    );
  }
}
