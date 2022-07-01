import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/api/seat_generator.dart';
import 'package:travel_smartapp/domain/controllers.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/providers/booking_provider.dart';
import 'package:travel_smartapp/extension/list/filter.dart';
import 'package:travel_smartapp/pages/booking/select_sheet/select_seat_constants.dart';

class ExectiveWidget extends StatefulWidget {
  final List<String> seats;
  const ExectiveWidget({Key? key, required this.seats}) : super(key: key);

  @override
  State<ExectiveWidget> createState() => _ExectiveWidgetState();
}

class _ExectiveWidgetState extends State<ExectiveWidget> {
  double seatSize = 35.0;
  final SeatController seatController = Get.put(SeatController());
  void switchSeat(Seat seat) {
    final provider = Provider.of<BookingProvider>(context, listen: false);

    // Add or Remove seat from booking provider
    setState(() {
      if (!provider.selectedSeats.seatContains(seat)) {
        provider.addSeat(seat);
      } else {
        provider.removeSeat(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding),
      child: Center(child: buildExecutive()),
    );
  }

  Widget buildExecutive() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      padding: const EdgeInsets.all(kPadding * 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: ['A', 'B', 'CENTER', 'C', 'D'].map((e) {
            if (e == 'CENTER') {
              return buildExecutiveRowLabel();
            } else {
              return buildExecutiveRow(e);
            }
          }).toList()),
    );
  }

  Widget buildExecutiveRow(String column) {
    return GetX<SeatController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: seatSize,
            height: seatSize,
            child: Center(child: Text(column)),
          ),
          ...getSeatsByColumn(controller.items.filter(widget.seats), column)
              .map((e) => _buildSeatButton(seatBox: e, group: column))
              .toList()
        ],
      );
    });
  }

  Widget _buildSeatButton({required String group, required Seat seatBox}) {
    IconData icon;
    Color color = kSecondaryColor;

    if (seatBox.bookingID != null) {
      // Unavailable
      icon = unavailabelIcon;
      color = Colors.grey;
    } else {
      // Get Selected Seats from Booking Provider
      final selctedSeats = Provider.of<BookingProvider>(context).selectedSeats;

      if (selctedSeats.seatContains(seatBox)) {
        // Selected
        icon = selectedIcon;
      } else {
        // Availabel
        icon = availabelIcon;
      }
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius * .2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //  Check Seat is Availabel
            if (seatBox.bookingID == null) {
              // Switch Seat Mode
              switchSeat(seatBox);
            }
          },
          child: SizedBox(
            width: seatSize,
            height: seatSize,
            child: Icon(
              icon,
              color: color,
              size: seatSize * .9,
            ),
          ),
        ),
      ),
    );
  }

  Column buildExecutiveRowLabel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30),
        ...List.generate(
            10,
            (index) => SizedBox(
                  width: seatSize,
                  height: seatSize,
                  child: Center(
                    child: Text((index + 1).toString(),
                        textAlign: TextAlign.center),
                  ),
                ))
      ],
    );
  }
}
