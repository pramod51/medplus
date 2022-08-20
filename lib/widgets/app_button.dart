import 'package:flutter/material.dart';
import 'package:medplus/res/palette.dart';

class Throttler {
  final int throttleGapInMs;

  Throttler({this.throttleGapInMs = 500});

  int? _lastActionTime;

  void run(VoidCallback? action) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (_lastActionTime == null || now - _lastActionTime! > throttleGapInMs) {
      _lastActionTime = now;
      action?.call();
    }
  }
}

class AppElevatedBtn extends StatefulWidget {
  final double? width;
  final double height;
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color color;
  final EdgeInsets? padding;

  final Color textColor;

  const AppElevatedBtn({
    this.height = 39,
    this.width,
    required this.text,
    this.onPressed,
    this.buttonStyle,
    this.textStyle,
    this.icon,
    this.borderRadius = 245,
    this.color = Palette.buttonColor,
    this.textColor = Colors.white,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  AppElevatedBtnState createState() => AppElevatedBtnState();
}

class AppElevatedBtnState extends State<AppElevatedBtn> {
  final throttler = Throttler(throttleGapInMs: 500);

  @override
  Widget build(BuildContext context) {
    final style = widget.buttonStyle ??
        ButtonStyle(
            backgroundColor: MaterialStateProperty.all(widget.color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            )));
    final onPressed = widget.onPressed != null
        ? () {
            throttler.run(() {
              widget.onPressed?.call();
            });
          }
        : null;

    if (widget.icon != null) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: widget.icon!,
          label: text,
          style: style,
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: text,
      ),
    );
  }

  Widget get text {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        widget.text,
        style: widget.textStyle ??
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.textColor,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class AppOutlinedBtn extends StatefulWidget {
  final double? width;
  final double height;
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color color;
  final Color textColor;

  const AppOutlinedBtn({
    this.height = 39,
    this.width,
    required this.text,
    this.onPressed,
    this.buttonStyle,
    this.textStyle,
    this.icon,
    this.borderRadius = 6.0,
    this.color = Palette.textLight,
    this.textColor = Palette.textLight,
    Key? key,
  }) : super(key: key);

  @override
  AppOutlinedBtnState createState() => AppOutlinedBtnState();
}

class AppOutlinedBtnState extends State<AppOutlinedBtn> {
  final throttler = Throttler(throttleGapInMs: 500);

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      side: MaterialStateProperty.resolveWith(
        (states) => BorderSide(
          color: widget.color,
          width: 1,
        ),
      ),
    );
    final onPressed = widget.onPressed != null
        ? () {
            throttler.run(() {
              widget.onPressed?.call();
            });
          }
        : null;

    if (widget.icon != null) {
      return SizedBox(
        height: widget.height,
        //width: widget.width,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: widget.icon!,
          label: text,
          style: style,
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: text,
      ),
    );
  }

  Widget get text {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        widget.text,
        style: widget.textStyle ??
            TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
