import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medplus/res/assets.dart';
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
  }) : super(key: key);

  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Alignment alignment;
  final Color? placeholderBgColor;

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
      alignment: Alignment.center,
      width: width,
      height: height,
      color: Palette.darkBg.withOpacity(0.5),
      child: SvgPicture.asset(Assets.ic_loading_img),
    );
  }
}
