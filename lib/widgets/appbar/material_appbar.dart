import 'package:flutter/material.dart';

AppBar customAppBar(
    {required String title, Widget? leading, List<Widget>? actions}) {
  return AppBar(
    leading: leading,
    title: Text(title, style: const TextStyle(color: Colors.black87)),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    actions: actions,
  );
}
