import 'package:flutter/material.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

Future<void> openPaymentCancelled(BuildContext context) async {
  return await showGenericDialog<void>(
    context,
    color: Colors.red,
    icon: Icons.cancel_rounded,
    header: context.loc!.payment_error_header,
    content: context.loc!.payment_error_body,
    callBack: () => {
      GenericDialogButton(text: context.loc!.close, primary: true): null,
    },
  );
}
