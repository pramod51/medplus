import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class AppRadioButton extends StatelessWidget {
  final bool value;
  final String label;
  final VoidCallback onTap;
  const AppRadioButton({
    Key? key,
    required this.value,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
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
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
                color: Palette.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
