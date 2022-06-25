import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Themes on BuildContext {
  ThemeData get themes => Theme.of(this);
}
