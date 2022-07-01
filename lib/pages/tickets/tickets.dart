import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/booking_service.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_schedule_service.dart';
import 'package:travel_smartapp/domain/cloud_services/train_service.dart';
import 'package:travel_smartapp/domain/cloud_services/user_service.dart';
import 'package:travel_smartapp/domain/models/booking_model.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/domain/models/train_model.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';
import 'package:travel_smartapp/domain/models/user_model.dart';
import 'package:travel_smartapp/enums/ticket/tag.dart';
import 'package:travel_smartapp/extension/context/themes.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/clipper/custom_ticket_cliper_horizontal.dart';
import 'package:travel_smartapp/widgets/divider/dashed_divider_verticle.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themes.brightness == Brightness.light
          ? Colors.grey.shade100
          : null,
      appBar: customAppBar(context, title: "Your Bookings"),
      body: StreamBuilder<UserModel>(
          stream: UserService.firebase()
              .readDoc(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            List<String> bookings = snapshot.data!.bookings ?? [];
            return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => bookingTicket(bookings[index]),
                          childCount: bookings.length))
                ]);
          }),
    );
  }

  Widget bookingTicket(String booking) {
    return StreamBuilder<TrainBooking>(
        stream: BookingService.firebase().readDoc(booking),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          TrainBooking trainBooking = snapshot.data!;
          return buildBookingTicketWidget(context, booking: trainBooking);
        });
  }

  Padding buildBookingTicketWidget(BuildContext context,
      {required TrainBooking booking}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, kPadding),
      child: ClipPath(
        clipper: CustomClipperHorizontal(
            right: 50 + kPadding * 2 - 30 / 2, holeRadius: 30),
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 150,
          decoration: BoxDecoration(
            color: context.themes.cardColor,
            borderRadius: BorderRadius.circular(kBorderRadius * .6),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(kPadding * .8),
                      child: FutureBuilder<List<Object>>(
                          future: fetchSchedule(booking.route),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const SizedBox();
                            Train train = snapshot.data![0] as Train;
                            TrainStation startStation =
                                snapshot.data![1] as TrainStation;
                            TrainStation endStation =
                                snapshot.data![2] as TrainStation;
                            TrainSchedule schedule =
                                snapshot.data![3] as TrainSchedule;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ticketTopBar(
                                  context,
                                  date: schedule.arrivalTime,
                                ),
                                const SizedBox(height: kPadding * .4),
                                _trainName(train.name!),
                                _trainType(train.type!),
                                _trainRoute(
                                  context,
                                  from: startStation.name!,
                                  to: endStation.name!,
                                )
                              ],
                            );
                          }))),
              const DashedDividerHorizontal(dash: 30, color: Colors.grey),
              buildTicketCode(context, booking: booking.id!)
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Object>> fetchSchedule(String route) async {
    return await TrainScheduleService.firebase().readDocFuture(route).then(
          (schedule) => Future.wait([
            //Train Future
            TrainService.firebase().readDocFuture(schedule.train),
            //Start Station
            StationService.firebase().readDocFuture(schedule.startStation),
            //End Station
            StationService.firebase().readDocFuture(schedule.endStation),
            //Train Schedule
            Future.value(schedule),
          ]),
        );
  }

  Expanded _trainRoute(BuildContext context,
      {required String from, required String to}) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              Icons.train_rounded,
              size: kFontSize * .7,
              color:
                  context.themes.textTheme.bodyText1?.color?.withOpacity(0.8),
            ),
            const SizedBox(width: kPadding * .4),
            Text(
              "$from to $to",
              style: TextStyle(
                fontSize: kFontSize * .7,
                color:
                    context.themes.textTheme.bodyText1?.color?.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _trainType(String trainType) {
    return Text(
      trainType,
      style: const TextStyle(
        fontSize: kFontSize * .6,
        color: Colors.grey,
      ),
    );
  }

  Text _trainName(String trainName) {
    return Text(
      trainName,
      style: const TextStyle(
        fontSize: kFontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Row _ticketTopBar(BuildContext context, {required DateTime date}) {
    return Row(
      children: [
        buildStatusTag(
          date.isAfter(DateTime.now()) ? TicketTag.upcoming : TicketTag.expired,
        ),
        const SizedBox(width: kPadding / 2),
        Text(
          DateFormat("hh:mm").format(date),
          style: TextStyle(
            color: context.themes.textTheme.bodyText1?.color?.withOpacity(0.8),
          ),
        )
      ],
    );
  }

  Container buildStatusTag(TicketTag tag) {
    String text;
    Color color;
    switch (tag) {
      case TicketTag.upcoming:
        text = "upcoming";
        color = Colors.green;
        break;
      case TicketTag.expired:
        text = "expired";
        color = Colors.red;
        break;
      default:
        text = "unavailable";
        color = Colors.grey;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );
  }

  RotatedBox buildTicketCode(BuildContext context, {required String booking}) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        color: Colors.white,
        child: BarcodeWidget(
          barcode: Barcode.code128(),
          data: booking,
          style: const TextStyle(
            fontSize: kFontSize * .3,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
