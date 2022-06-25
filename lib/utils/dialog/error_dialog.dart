import 'package:flutter/cupertino.dart';
import 'package:travel_smartapp/utils/dialog/generic_dialog.dart';

void showErrorDialog(BuildContext context, {required String message}) {
  showGenericDialog<void>(context,
      title: "You Have an Error",
      content: message,
      callBack: () => {
            'OK': null,
          });
}
