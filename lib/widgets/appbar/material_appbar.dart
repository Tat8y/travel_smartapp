import 'package:flutter/material.dart';
import 'package:travel_smartapp/extension/context/themes.dart';

AppBar customAppBar(BuildContext context,
    {required String title, Widget? leading, List<Widget>? actions}) {
  return AppBar(
    leading: leading,
    title: Text(title,
        style: TextStyle(color: context.themes.textTheme.bodyText1?.color)),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    actions: actions,
  );
}
