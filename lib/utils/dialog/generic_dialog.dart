import 'package:flutter/material.dart';

typedef DialogCallBackOptions<T> = Map<String, T> Function();

void showGenericDialog<T>(
  BuildContext context, {
  required String title,
  required String content,
  required DialogCallBackOptions<T> callBack,
}) {
  final options = callBack();

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: options.entries
                .map((e) => TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(e.value);
                      },
                      child: Text(e.key),
                    ))
                .toList(),
          ));
}
