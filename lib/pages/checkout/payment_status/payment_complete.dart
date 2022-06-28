import 'package:flutter/material.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

Future<void> openPaymentComplete(BuildContext context) async {
  return await showGenericDialog<void>(
    context,
    color: Colors.green,
    icon: Icons.done,
    header: "Payment Successfull",
    content:
        "You Have Successfully Purches Train Seats.Thank you for Using Travel Smart App",
    callBack: () => {
      GenericDialogButton(text: "OK", primary: true): null,
    },
  );
}
