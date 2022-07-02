import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/seat_service.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_model.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/domain/strings.dart';
import 'package:travel_smartapp/extension/list/filter.dart';
import 'package:travel_smartapp/pages/root/root.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';
import 'package:travel_smartapp/widgets/clipper/custom_ticket_cliper.dart';
import 'package:travel_smartapp/widgets/divider/dashed_divider.dart';

class BookingCode extends StatelessWidget {
  final TrainBooking booking;
  const BookingCode({Key? key, required this.booking}) : super(key: key);

  Future<List<Object>> ticketFuture(
      {required TrainBooking trainBooking}) async {
    return await TrainScheduleService.firebase()
        .readDocFuture(trainBooking.schedule)
        .then((schedule) {
      return Future.wait([
        // Train Service
        TrainService.firebase().readDocFuture(schedule.train),

        // Start Station
        StationService.firebase().readDocFuture(schedule.startStation),

        // End Station
        StationService.firebase().readDocFuture(schedule.endStation),

        // User Service
        UserService.firebase()
            .readDocFuture(FirebaseAuth.instance.currentUser!.uid),

        Future.value(schedule),

        // Seat Service
        SeatService.firebase().readCollectionFuture(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildBookingCard(context),
        CustomButton(
            text: "Goto Home",
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }

  Widget buildBookingCard(BuildContext context) {
    return FutureBuilder<List<Object>>(
        future: ticketFuture(trainBooking: booking),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Object?> response = snapshot.data!;

          Train train = response[0] as Train;
          TrainStation startStation = response[1] as TrainStation;
          TrainStation endStation = response[2] as TrainStation;
          UserModel user = response[3] as UserModel;
          TrainSchedule schedule = response[4] as TrainSchedule;
          List<Seat> seats = (response[5] as List<Seat>).filter(booking.seats);

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
                    Text(train.name!,
                        style: const TextStyle(
                          fontSize: kFontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                    Text(train.type!,
                        style: const TextStyle(
                          fontSize: kFontSize * .6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        )),
                    buildRoute(from: startStation.name!, to: endStation.name!),
                    ...{
                      "Full Name": "${user.firstName} ${user.secondName}",
                      "Arrival Time":
                          DateFormat.yMEd().add_jms().format(booking.time),
                      "Seat": generateSeatNumberFromList(seats)
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
                        style: const TextStyle(color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget cardInfo({required String leading, required String traling}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding * .1),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              leading,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                traling,
                style: const TextStyle(color: Colors.black54),
              )),
        ],
      ),
    );
  }

  Widget buildRoute({required String from, required String to}) {
    return Row(
      children: [
        Expanded(
          child: _buildRouteStation(
            label: "From",
            text: from,
          ),
        ),
        Expanded(
          child: _buildRouteStation(
            label: "To",
            text: to,
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
              color: Colors.black54,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kFontSize * .8,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(top: kPadding * .3),
          //   child: Text(
          //     "Wed April 1 12:20",
          //     style: TextStyle(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
