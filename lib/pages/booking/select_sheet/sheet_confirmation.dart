import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/support_models/booking_data_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';
import 'package:travel_smartapp/domain/strings.dart';
import 'package:travel_smartapp/extension/list/filter.dart';
import 'package:travel_smartapp/pages/checkout/payment_confirmation/paymnet_confrimation.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

void openSheetConfirmation(BuildContext context,
    {required BookingDataModel bookingData}) {
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
                FutureBuilder<List<Seat>>(
                    future: SeatService.firebase().readCollectionFuture(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();
                      return cardConfirmationDetailsRow(
                        title: "Your Seat",
                        value: generateSeatNumberFromList(
                          snapshot.data?.filter(bookingData.seats) ?? [],
                        ),
                      );
                    }),
                const SizedBox(height: kPadding * .5),
                cardConfirmationDetailsRow(
                  title: "Total Price",
                  value:
                      "${calculatePrice(route: bookingData.route, seats: bookingData.seats)} LKR",
                ),
                const SizedBox(height: kPadding),
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    //createBookingTicket(trainBooking);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => PaymentConfirmation(
                          trainBooking: TrainBooking(
                            time: DateTime.now(),
                            seats: bookingData.seats,
                            schedule: bookingData.route.schedule.id!,
                            from: bookingData.route.from,
                            to: bookingData.route.to,
                          ),
                          bookingData: bookingData,
                        ),
                      ),
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

double calculatePrice(
    {required TravelRoute route, required List<String> seats}) {
  double ratio = route.schedule.calculateLengthRatio(route);
  double seatPrice = 250.0 * ratio;
  return (seatPrice * seats.length).roundToDouble();
}
