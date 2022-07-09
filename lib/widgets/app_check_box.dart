import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class AppCheckBox extends StatefulWidget {
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
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool isFilled = false;
  @override
  void initState() {
    super.initState();
    isFilled = widget.filled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isFilled = !isFilled;
        widget.onTap?.call(!widget.filled);
      }),
      child: Padding(
        padding: widget.padding, // For Tap Target
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            buildCheckBox,
            if (widget.child != null || widget.label.isNotEmpty) ...[
              SizedBox(width: widget.innerPadding),
              Expanded(
                child: widget.child ??
                    Text(
                      widget.label,
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
      width: widget.size,
      height: widget.size,
      // padding: EdgeInsets.all(shape == BoxShape.circle ? 4 : 1),
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: isFilled ? widget.filledColor : Colors.transparent,
        border: isFilled ? null : border,
        borderRadius: BorderRadius.circular(5),
      ),
      child: AnimatedScale(
        scale: isFilled ? 1 : 0,
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
