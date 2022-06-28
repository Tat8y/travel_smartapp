import 'package:flutter/material.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context,
    {required String message}) async {
  await showGenericDialog<void>(
    context,
    color: Colors.red,
    icon: Icons.close,
    header: "You Have an Error",
    content: message,
    callBack: () => {
      GenericDialogButton(text: "CANCEL"): null,
      GenericDialogButton(text: "OK", primary: true): null,
    },
  );
}
