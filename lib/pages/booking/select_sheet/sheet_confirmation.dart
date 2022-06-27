import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/strings.dart';
import 'package:travel_smartapp/pages/checkout/payment_confirmation/paymnet_confrimation.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

void openSheetConfirmation(BuildContext context, TrainBooking trainBooking) {
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
                  value:
                      "Exec 1 - ${generateSeatNumberFromList(trainBooking.seats)}",
                ),
                const SizedBox(height: kPadding * .5),
                cardConfirmationDetailsRow(
                  title: "Total Price",
                  value: "${calculatePrice(trainBooking.seats)} LKR",
                ),
                const SizedBox(height: kPadding),
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    createBookingTicket(trainBooking);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const PaymentConfirmation()),
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

void createBookingTicket(TrainBooking trainBooking) async {
  await BookingService.firebase()
      .create(trainBooking.toMap())
      .then((booking) async {
    for (Seat seat in trainBooking.seats) {
      await SeatService.firebase()
          .update(
            id: seat.id!,
            json: seat.copyWith(bookingID: booking.id).toMap(),
          )
          .then((value) => print("Updated"));
    }

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await UserService.firebase().readDocFuture(uid).then((user) async {
      user.bookings?.add(booking.id!);
      return await UserService.firebase().update(
        id: user.uid!,
        json: user.toMap(),
      );
    });
  });
}

double calculatePrice(List<Seat> seats) {
  double seatPrice = 250.0;
  return seatPrice * seats.length;
}
