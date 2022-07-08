import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class SimpleChip extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool enable;
  final Function(bool enable)? onClick;
  const SimpleChip({
    Key? key,
    required this.text,
    this.isSelected = false,
    this.enable = true,
    this.onClick,
  }) : super(key: key);

  @override
  State<SimpleChip> createState() => _SimpleChipState();
}

class _SimpleChipState extends State<SimpleChip> {
  bool isEnable = false;

  @override
  void initState() {
    super.initState();
    isEnable = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: GestureDetector(
        onTap: () => setState(() {
          isEnable = !isEnable;
          if (widget.onClick != null) {
            widget.onClick!(isEnable);
          }
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          constraints: const BoxConstraints(minWidth: 50),
          height: 23,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isEnable && widget.enable
                  ? Palette.primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(245),
              border: Border.all(
                  color: isEnable && widget.enable
                      ? Palette.primaryColor
                      : const Color(0xffDEDEDE))),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 12,
              color:
                  isEnable && widget.enable ? Colors.white : Palette.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
