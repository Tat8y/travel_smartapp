import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code.dart';
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
                      "Exec 1 - ${trainBooking.seats.map((e) => e.row.toString() + e.column).join(' / ')}",
                ),
                const SizedBox(height: kPadding * .5),
                cardConfirmationDetailsRow(
                  title: "Total Price",
                  value: "${trainBooking.seats.length * 250} LKR",
                ),
                const SizedBox(height: kPadding),
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    print("uploading");
                    BookingService.firebase()
                        .create(trainBooking.toMap())
                        .then((booking) async {
                      print(booking.id);
                      for (var element in trainBooking.seats) {
                        await SeatService.firebase()
                            .update(
                                id: element.id!,
                                json: element
                                    .update(bookingID: booking.id)
                                    .toMap())
                            .then((value) => print("Updated"));
                      }
                    });

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (builder) => const BookingCode()),
                    // );
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
