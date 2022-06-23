import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

void openSheetConfirmation(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(kBorderRadius)),
      ),
      builder: (context) => Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: kPadding * .5),
                cardConfirmationDetailsRow(
                  title: "Your Seat",
                  value: "Exec 3/ Seat 7A",
                ),
                const SizedBox(height: kPadding * .5),
                cardConfirmationDetailsRow(
                  title: "Total Price",
                  value: "250 LKR",
                ),
                const SizedBox(height: kPadding),
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const BookingCode()),
                    );
                  },
                  constraints: const BoxConstraints.expand(height: 50),
                )
              ],
            ),
          ));
}

Widget cardConfirmationDetailsRow(
    {required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(title), Text(value)],
  );
}
