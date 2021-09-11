import 'package:breaking_bad_bad/core/color_palette.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.keyboardType,
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final void Function(String) onChanged;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(color: ColorPalette.kPrimaryBackgroundColor);
    return TextFormField(
      controller: controller,
      cursorColor: ColorPalette.kPrimaryBackgroundColor,
      keyboardType: keyboardType,
      style: textStyle,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textStyle,
        border: InputBorder.none,
      ),
    );
  }
}
