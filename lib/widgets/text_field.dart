import 'package:flutter/material.dart';

import '../const/import.dart';

class VTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final Color? backgroundColor;
  final TextInputAction? inputAction;
  final double? hight;
  final int? maxSymbol;
  final TextAlignVertical? alignVertical;
  final bool? enabled;
  final Function(String val)? onChange;
  final TextInputType? keyboardType;
  final bool? autofocus;
  const VTextField({
    required this.controller,
    required this.hint,
    this.autofocus,
    this.backgroundColor,
    this.maxSymbol,
    this.hight,
    this.onChange,
    this.keyboardType,
    this.alignVertical,
    this.enabled,
    this.maxLines,
    this.inputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight ?? 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          autofocus: autofocus != null ? autofocus! : false,
          style: const TextStyle(color: Colors.white),
          enabled: enabled,
          showCursor: false,
          onChanged: onChange,
          keyboardType: keyboardType,
          textAlignVertical: alignVertical ?? TextAlignVertical.top,
          textInputAction: inputAction ?? TextInputAction.done,
          controller: controller,
          maxLines: maxLines,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: primary,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.w300,
            ),
            hintText: hint,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
