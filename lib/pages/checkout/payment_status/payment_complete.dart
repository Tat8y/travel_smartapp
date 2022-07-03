import 'package:flutter/material.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

Future<void> openPaymentComplete(BuildContext context) async {
  return await showGenericDialog<void>(
    context,
    color: Colors.green,
    icon: Icons.done,
    header: context.loc!.payment_succesfull_header,
    content: context.loc!.payment_succesfull_body,
    callBack: () => {
      GenericDialogButton(text: context.loc!.ok, primary: true): null,
    },
  );
}
