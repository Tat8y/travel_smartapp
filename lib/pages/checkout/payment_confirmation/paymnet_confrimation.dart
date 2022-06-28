import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';
import 'package:travel_smartapp/domain/payment/payment_exception.dart';
import 'package:travel_smartapp/domain/payment/payment_service.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';
import 'package:travel_smartapp/pages/checkout/payment_status/payment_cancel.dart';
import 'package:travel_smartapp/pages/checkout/payment_status/payment_complete.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class PaymentConfirmation extends StatelessWidget {
  final TrainBooking trainBooking;
  const PaymentConfirmation({Key? key, required this.trainBooking})
      : super(key: key);

  Future<void> checkout(BuildContext context, double amount) async {
    try {
      await PaymentService.instance
          .makePayment(amount: amount)
          .then((value) async {
        await openPaymentComplete(context).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const BookingCode();
          }));
        });
      });
    } on PaymentCancelException {
      await openPaymentCancelled(context);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Confirm Order"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(kPadding),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(kBorderRadius * .8),
              ),
              child: buildTicketContent(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kPadding * .8),
            child: Text(
              "Total:  ${trainBooking.seats.length * 120}LKR",
              style: const TextStyle(
                fontSize: kFontSize * .9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: CustomButton(
              text: "Confirm Order",
              onPressed: () async =>
                  await checkout(context, trainBooking.seats.length * 120),
            ),
          ),
        ],
      ),
    );
  }

  Column buildTicketContent() => Column(
        children: [
          const Text(
            "Confirm Order",
            style: TextStyle(
              fontSize: kFontSize * .8,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          buildRoute(),
          const Divider(color: Colors.white),
          ...buildDetails(),
        ],
      );

  List<Widget> buildDetails() {
    return {
      "Number of Tickets": '${trainBooking.seats.length}',
      "Coupen Code": 'TRAVELSMART2022',
      "Discount": "36 LKR"
    }
        .entries
        .map((e) => buildDetailRow(
              title: e.key.toString(),
              value: e.value.toString(),
            ))
        .toList();
  }

  Widget buildDetailRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(top: kPadding * .8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRoute() {
    return FutureBuilder<TrainSchedule>(
        future:
            TrainScheduleService.firebase().readDocFuture(trainBooking.route),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          return Row(
            children: [
              Expanded(
                child: _buildRouteStation(
                  label: "From",
                  text: snapshot.data!.startStation,
                ),
              ),
              Expanded(
                child: _buildRouteStation(
                  label: "To",
                  text: snapshot.data!.endStation,
                ),
              )
            ],
          );
        });
  }

  Container _buildRouteStation({required String label, required String text}) {
    return Container(
      // alignment: Alignment.center,
      padding: const EdgeInsets.all(kPadding),
      child: FutureBuilder<TrainStation>(
          future: StationService.firebase().readDocFuture(text),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: kFontSize * .5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  snapshot.data?.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: kFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: kPadding * .3),
                  child: Text(
                    "Wed April 1 12:20",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
