import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class AppCheckBox extends StatelessWidget {
  final bool filled;
  final Widget? child;
  final BoxShape shape;
  final void Function(bool)? onTap;
  final EdgeInsets padding;
  final Color filledColor;
  final double size;
  final double innerPadding;
  final String label;
  final CrossAxisAlignment crossAxisAlignment;

  const AppCheckBox({
    Key? key,
    this.child,
    this.shape = BoxShape.circle,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.filled = false,
    this.filledColor = Palette.buttonColor,
    this.size = 20,
    this.label = '',
    this.innerPadding = 16,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(!filled);
      },
      child: Padding(
        padding: padding, // For Tap Target
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            buildCheckBox,
            if (child != null || label.isNotEmpty) ...[
              SizedBox(width: innerPadding),
              Expanded(
                child: child ??
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.textColor,
                      ),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget get buildCheckBox {
    BoxBorder border = Border.all(color: Palette.crayola, width: 1);
    return AnimatedContainer(
      width: size,
      height: size,
      // padding: EdgeInsets.all(shape == BoxShape.circle ? 4 : 1),
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: filled ? filledColor : Colors.transparent,
        border: filled ? null : border,
        borderRadius: BorderRadius.circular(5),
      ),
      child: AnimatedScale(
        scale: filled ? 1 : 0,
        curve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 250),
        child: const Icon(
          Icons.check,
          size: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
