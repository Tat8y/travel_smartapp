import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/extension/context/themes.dart';

class PointsView extends StatelessWidget {
  final UserModel? user;
  const PointsView({Key? key, this.user}) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kPadding),
            child: Image.asset(kReward),
          ),
          const Text(
            "Congratulations !",
            style: TextStyle(
              color: Colors.green,
              fontSize: kFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(kPadding / 2),
            child: Text(
              "36 Points",
              style: TextStyle(
                  fontSize: kFontSize * 1.5,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kPadding / 2),
            child: Text(
              "You are revarding with 10% discount for the next ride! Please use the code below for your next booking.",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.themes.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(kBorderRadius / 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onLongPress: () {
                  Clipboard.setData(
                    const ClipboardData(text: "TRAVELSMART2022"),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(kPadding / 2),
                  child: const Text("TRAVELSMART2022",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
