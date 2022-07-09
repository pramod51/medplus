import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    required this.url,
    this.fit = BoxFit.fill,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.placeholderBgColor,
    this.initChar = '',
  }) : super(key: key);

  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Alignment alignment;
  final Color? placeholderBgColor;
  final String initChar;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      errorBuilder: (_, __, ___) => error,
      frameBuilder: (context, child, frame, _) {
        if (frame == null) {
          // fallback to placeholder
          return error;
        }
        return child;
      },
      fit: fit,
      height: height,
      width: width,
      alignment: alignment,
    );
  }

  Widget get error {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Palette.primaryColor,
      ),
      child: Text(
        initChar,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
