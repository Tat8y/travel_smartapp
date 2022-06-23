import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final BoxConstraints constraints;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.constraints = const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: kSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius * 0.5),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding,
        vertical: kPadding * .6,
      ),
      elevation: 0,
      constraints: constraints,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: kFontSize * 0.8,
          color: Colors.black,
        ),
      ),
    );
  }
}
