import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const CustomTextFeild(
      {Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(kPadding * 0.5),
          isDense: true,
          hintText: hint,
          border: InputBorder.none,
          label: Text(hint)),
    );
  }
}
