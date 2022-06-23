import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';

class BookingCode extends StatelessWidget {
  const BookingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "ID 743650898"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBookingCard(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Text(
              "Train Route",
              style:
                  TextStyle(fontSize: kFontSize, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBookingCard() {
    return Container(
      padding: const EdgeInsets.all(kPadding * 1.1),
      margin: const EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          color: kPrimaryColor),
      child: Container(
        padding: const EdgeInsets.all(kPadding * 0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius / 2),
          color: Colors.white,
        ),
        child: Column(
          children: [
            cardInfo(leading: "Full Name", traling: "Alwis Gunarathne"),
            cardInfo(leading: "Date", traling: "18 April"),
            cardInfo(leading: "Arrival Time", traling: "12 : 10"),
            cardInfo(leading: "Seat", traling: "Exe 5 / Seat 8A"),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(bottom: kPadding * 0.5),
              child: Text("Booking Code    XXXXXXXX"),
            ),
            Container(height: 48, color: Colors.black)
          ],
        ),
      ),
    );
  }

  Widget cardInfo({required String leading, required String traling}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding * .1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: const TextStyle(color: Colors.black54),
          ),
          Text(traling),
        ],
      ),
    );
  }
}