import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medplus/res/palette.dart';

class InputFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final InputDecoration? decoration;
  final bool optional;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChange;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final bool enableSuggestions;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;
  final Color? outlineColor;
  final Color? textColor;
  final double fontSize;

  const InputFormField({
    Key? key,
    this.hint,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.decoration,
    this.optional = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChange,
    this.obscureText = false,
    this.keyboardType,
    this.autofillHints,
    this.inputFormatters,
    this.autofocus = false,
    this.enableInteractiveSelection = true,
    this.focusNode,
    this.enableSuggestions = false,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.outlineColor,
    this.textColor,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? Palette.textLight,
      ),
      textAlign: textAlign,
      enabled: enabled,
      // cursorHeight: 18,
      //cursorWidth: 0.7,
      cursorColor: Palette.darkBg,
      validator: validator,
      controller: controller,
      onChanged: onChange,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      autofocus: autofocus,
      focusNode: focusNode,
      enableSuggestions: enableSuggestions,
      autocorrect: false,
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: (decoration ?? const InputDecoration()).copyWith(
        hintStyle: TextStyle(
          fontSize: 13,
          color: textColor ?? Palette.textLight,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: outlineColor ?? Palette.darkBg,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: outlineColor ?? Palette.darkBg,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: outlineColor ?? Palette.darkBg,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        isDense: true,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(13, 18, 13, 18),
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          minHeight: 20,
        ),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
