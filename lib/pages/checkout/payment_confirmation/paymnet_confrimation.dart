import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/support_models/booking_data_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/payment/payment_exception.dart';
import 'package:travel_smartapp/domain/payment/payment_service.dart';
import 'package:travel_smartapp/extension/context/localization.dart';
import 'package:travel_smartapp/pages/booking/code/booking_code_sheet.dart';
import 'package:travel_smartapp/pages/checkout/payment_status/payment_cancel.dart';
import 'package:travel_smartapp/pages/checkout/payment_status/payment_complete.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class PaymentConfirmation extends StatelessWidget {
  final TrainBooking trainBooking;
  final BookingDataModel bookingData;
  const PaymentConfirmation(
      {Key? key, required this.trainBooking, required this.bookingData})
      : super(key: key);

  Future<TrainBooking> createBookingTicket(TrainBooking trainBooking) async {
    return await BookingService.firebase()
        .create(trainBooking.toMap())
        .then((booking) async {
      for (String seat in trainBooking.seats) {
        Seat _seat = await SeatService.firebase().readDocFuture(seat);

        await SeatService.firebase()
            .update(
              id: seat,
              json: _seat.copyWith(bookingID: booking.id).toMap(),
            )
            .then((value) => log("Updated"));
      }

      String uid = FirebaseAuth.instance.currentUser!.uid;
      await UserService.firebase().readDocFuture(uid).then((user) async {
        user.bookings?.add(booking.id!);
        return await UserService.firebase().update(
          id: user.uid!,
          json: user.toMap(),
        );
      });
      return booking;
    });
  }

  Future<void> checkout(BuildContext context, double amount) async {
    try {
      await PaymentService.instance
          .makePayment(amount: amount)
          .then((value) async {
        TrainBooking booking = await createBookingTicket(trainBooking);
        await openPaymentComplete(context).then((value) {
          showBookingCode(context, booking: booking);
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
      appBar: customAppBar(context, title: context.loc!.confirm_order),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.loc!.you_need_to_total_pay,
                    style: const TextStyle(
                      fontSize: kFontSize * .7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: kPadding * .8),
                    child: Text(
                      "${calculatePrice(route: bookingData.route, seats: trainBooking.seats)} LKR",
                      style: const TextStyle(
                        fontSize: kFontSize * 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(kPadding),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(kBorderRadius * .8),
                ),
                child: buildTicketContent(context),
              ),
            ),
            buildnotice(context, color: Colors.red.shade400),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kPadding),
              child: CustomButton(
                text: context.loc!.pay,
                constraints: const BoxConstraints.expand(height: 50),
                onPressed: () async => await checkout(
                    context,
                    calculatePrice(
                        route: bookingData.route, seats: trainBooking.seats)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildnotice(BuildContext context, {required Color color}) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      margin: const EdgeInsets.symmetric(horizontal: kPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(kBorderRadius / 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.info, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                context.loc!.notice,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            context.loc!.payment_notice,
            style: TextStyle(
              color: color.withOpacity(.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTicketContent(BuildContext context) =>
      FutureBuilder<List<Object>>(
          future: fetchSchedule(trainBooking.schedule),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            return Column(
              children: [
                Text(
                  context.loc!.confirm_order,
                  style: const TextStyle(
                    fontSize: kFontSize * .8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                buildRoute(
                  context,
                  from: (snapshot.data![1] as TrainStation).name!,
                  to: (snapshot.data![2] as TrainStation).name!,
                ),
                const Divider(color: Colors.white),
                ...buildDetails(context,
                    train: (snapshot.data![0] as Train).name!),
              ],
            );
          });

  List<Widget> buildDetails(BuildContext context, {required String train}) {
    return {
      context.loc!.train: train,
      context.loc!.number_of_seats: '${trainBooking.seats.length}',
      context.loc!.coupen_code: 'TRAVELSMART2022',
      context.loc!.discount: "0 LKR"
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

  Widget buildRoute(BuildContext context,
      {required String from, required String to}) {
    return Row(
      children: [
        Expanded(
          child: _buildRouteStation(
            label: context.loc!.from,
            text: from,
          ),
        ),
        Expanded(
          child: _buildRouteStation(
            label: context.loc!.to,
            text: to,
          ),
        )
      ],
    );
  }

  Container _buildRouteStation({required String label, required String text}) {
    return Container(
        // alignment: Alignment.center,
        padding: const EdgeInsets.all(kPadding),
        child: Column(
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
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: kFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: kPadding * .3),
            //   child: Text(
            //     "Wed April 1 12:20",
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  Future<List<Object>> fetchSchedule(String route) async {
    return await TrainScheduleService.firebase().readDocFuture(route).then(
          (schedule) => Future.wait([
            //Train Future
            TrainService.firebase().readDocFuture(schedule.train),
            //Start Station
            StationService.firebase().readDocFuture(trainBooking.from),
            //End Station
            StationService.firebase().readDocFuture(trainBooking.to),
            //Train Schedule
            Future.value(schedule),
          ]),
        );
  }
}

double calculatePrice(
    {required TravelRoute route, required List<String> seats}) {
  double ratio = route.schedule.calculateLengthRatio(route);
  double seatPrice = 250.0 * ratio;
  return (seatPrice * seats.length).roundToDouble();
}
