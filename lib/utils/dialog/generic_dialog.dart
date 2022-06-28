import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';

typedef DialogCallBackOptions<T> = Map<GenericDialogButton, T> Function();

class GenericDialogButton {
  final String text;
  final bool primary;

  GenericDialogButton({required this.text, this.primary = false});
}

Future<T?> showGenericDialog<T>(
  BuildContext context, {
  required Color color,
  required IconData icon,
  required String header,
  required String content,
  required DialogCallBackOptions<T> callBack,
}) {
  return showDialog(
      context: context,
      builder: (context) => _GenericDialog<T>(
            color: color,
            content: content,
            header: header,
            icon: icon,
            callBackOptions: callBack,
          ));
}

class _GenericDialog<T> extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String header;
  final String content;
  final DialogCallBackOptions<T> callBackOptions;
  const _GenericDialog(
      {Key? key,
      required this.color,
      required this.icon,
      required this.header,
      required this.content,
      required this.callBackOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kPadding * .4),
          buildThumbIcon(),
          buildHeader(),
          buildContent(),
          const SizedBox(height: kPadding * .7),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: callBackOptions().entries.map((e) {
              return buildButton(
                  onTap: () {
                    Navigator.of(context).pop(e.value);
                  },
                  text: e.key.text,
                  primary: e.key.primary);
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Function() onTap,
    bool primary = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding / 3),
      child: RawMaterialButton(
        onPressed: onTap,
        fillColor: primary ? color : null,
        textStyle: TextStyle(
          color: primary ? Colors.white : color,
          fontWeight: FontWeight.w500,
        ),
        elevation: 0.0,
        shape: primary
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius * .6),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius * .6),
                side: BorderSide(width: 1, color: color)),
        child: Text(text),
      ),
    );
  }

  Text buildContent() {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black54),
    );
  }

  Padding buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding),
      child: Text(
        header,
        style: TextStyle(
            color: color, fontSize: kFontSize, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildThumbIcon() {
    return Container(
      padding: const EdgeInsets.all(kPadding * .5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kPadding * 1.2),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      child: Icon(
        icon,
        color: color,
        size: 50,
      ),
    );
  }
}
