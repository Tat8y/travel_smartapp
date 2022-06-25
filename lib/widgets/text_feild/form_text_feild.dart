import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';

class CustomFormTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final String hint;
  final TextInputType inputType;
  final bool enabled;

  final bool obscureText;
  const CustomFormTextFeild({
    Key? key,
    required this.controller,
    required this.hint,
    this.focusNode,
    this.onEditingComplete,
    this.inputType = TextInputType.name,
    this.enabled = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      keyboardType: inputType,
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPadding),
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: BorderSide.none),
        isDense: true,
      ),
    );
  }
}
