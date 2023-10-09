// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  const PrimaryTextfield(
      {Key? key,
      this.controller,
      this.labelText,
      this.hintText,
      this.helperText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.obscureText,
      this.readOnly,
      this.validator,
      this.onChanged,
      this.maxLines,
      this.withBorderSide = false})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText, hintText, helperText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText, readOnly;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final bool withBorderSide;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      controller: controller,
      decoration: InputDecoration(
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(
            color: Color(0xffFDB415), fontWeight: FontWeight.w600),
        errorStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
            fontWeight: FontWeight.w600),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            borderSide: withBorderSide
                ? const BorderSide(color: Colors.black45, width: 1.0)
                : BorderSide.none),
        filled: true,
        fillColor: const Color(0xffFFFBFE),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
    );
  }
}
