import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/clipper/custom_ticket_cliper.dart';
import 'package:travel_smartapp/widgets/divider/dashed_divider.dart';

class BookingCode extends StatelessWidget {
  final TrainBooking booking;
  const BookingCode({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Your E - Ticket"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBookingCard(context),
        ],
      ),
    );
  }

  Widget buildBookingCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kPadding),
      padding: const EdgeInsets.all(kPadding * 1.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: kPrimaryColor,
      ),
      child: ClipPath(
        clipper: DolDurmaClipper(holeRadius: 30, bottom: 70 + kPadding),
        child: Container(
          padding: const EdgeInsets.all(kPadding * 0.8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Text("Ruhunu Kumari",
                  style: TextStyle(
                    fontSize: kFontSize,
                    fontWeight: FontWeight.w500,
                  )),
              const Text("Express Train",
                  style: TextStyle(
                    fontSize: kFontSize * .6,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  )),
              buildRoute(),
              ...{
                "Full Name": "Alwis Gunarathne",
                "Date": "18 April",
                "Arrival Time": "12:10",
                "Executive": "1",
                "Seat": "8A"
              }
                  .entries
                  .map((e) => cardInfo(leading: e.key, traling: e.value))
                  .toList(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: kPadding),
                child: DashedDivider(dash: 50, color: kPrimaryColor),
              ),
              SizedBox(
                height: 70,
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: booking.id!,
                ),
              )
            ],
          ),
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

  Widget buildRoute() {
    return Row(
      children: [
        Expanded(
          child: _buildRouteStation(
            label: "From",
            text: "Galle",
          ),
        ),
        Expanded(
          child: _buildRouteStation(
            label: "To",
            text: "Colombo",
          ),
        )
      ],
    );
  }

  Container _buildRouteStation({required String label, required String text}) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kFontSize * .5,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: kPadding * .3),
            child: Text(
              "Wed April 1 12:20",
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
