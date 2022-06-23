import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final String hint;
  const CustomTextFeild(
      {Key? key,
      required this.controller,
      required this.hint,
      this.focusNode,
      this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(kPadding * 0.5),
          isDense: true,
          hintText: hint,
          border: InputBorder.none,
          label: Text(hint)),
    );
  }
}
