import 'package:flutter/material.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

Future<void> openPaymentCancelled(BuildContext context) async {
  return await showGenericDialog<void>(
    context,
    color: Colors.orange,
    icon: Icons.bolt_rounded,
    header: "Payment Cancelled",
    content: "Payment Error Body",
    callBack: () => {
      GenericDialogButton(text: "CLOSE", primary: true): null,
    },
  );
}