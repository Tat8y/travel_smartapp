import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/api/seat_generator.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/providers/booking_provider.dart';
import 'package:travel_smartapp/extentions/list/filter.dart';

class ExectiveWidget extends StatefulWidget {
  final List<Seat> data;
  final Function(List<Seat>) onTap;
  const ExectiveWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  State<ExectiveWidget> createState() => _ExectiveWidgetState();
}

class _ExectiveWidgetState extends State<ExectiveWidget> {
  switchSeat(Seat seat) {
    final provider = context.read<BookingProvider>();
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

  Column buildExecutiveRow(String column) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Center(child: Text(column)),
        ),
        ...getSeatsByColumn(widget.data, column)
            .map((e) => _buildSeatButton(seatBox: e, group: column))
            .toList()
      ],
    );
  }

  Widget _buildSeatButton({required String group, required Seat seatBox}) {
    IconData icon;
    Color color = kSecondaryColor;

    if (seatBox.bookingID != null) {
      //Unavailable
      icon = Icons.disabled_by_default_rounded;
      color = Colors.grey;
    } else {
      //Available
      final selctedSeats = Provider.of<BookingProvider>(context).selectedSeats;
      if (selctedSeats.seatContains(seatBox)) {
        icon = Icons.check_box;
      } else {
        icon = Icons.check_box_outline_blank_outlined;
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
            switchSeat(seatBox);
          },
          child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(icon, color: color),
          ),
        ),
      ),
    );
  }

  Column buildExecutiveRowLabel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        ...List.generate(
            10,
            (index) => SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text((index + 1).toString(),
                        textAlign: TextAlign.center),
                  ),
                ))
      ],
    );
  }
}


// class ExectiveWidget extends StatefulWidget {
//   final Map<String, Map<int, SeatType>> data;
//   final Function(Map<String, Map<int, SeatType>>) onTap;
//   const ExectiveWidget({Key? key, required this.data, required this.onTap})
//       : super(key: key);

//   @override
//   State<ExectiveWidget> createState() => _ExectiveWidgetState();
// }

// class _ExectiveWidgetState extends State<ExectiveWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   SeatType switchSheetType(SeatType? seat) {
//     setState(() {
//       if (seat == SeatType.selected) {
//         seat = SeatType.available;
//       } else {
//         seat = SeatType.selected;
//       }
//       widget.onTap(widget.data);
//     });
//     return seat ?? SeatType.unavailable;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: kPadding),
//       child: Center(child: buildExecutive()),
//     );
//   }

//   Widget buildExecutive() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(kBorderRadius),
//       ),
//       padding: const EdgeInsets.all(kPadding * 2),
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             buildExecutiveRow("A"),
//             buildExecutiveRow("B"),
//             buildExecutiveRowLabel(),
//             buildExecutiveRow("C"),
//             buildExecutiveRow("D"),
//           ]),
//     );
//   }

//   Column buildExecutiveRow(String group) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: 30,
//           height: 30,
//           child: Center(child: Text(group)),
//         ),
//         ...widget.data[group]?.entries
//                 .map((e) => _buildSeatButton(entry: e, group: group))
//                 .toList() ??
//             []
//       ],
//     );
//   }

//   Widget _buildSeatButton(
//       {required String group, required MapEntry<int, SeatType> entry}) {
//     IconData icon;
//     Color color = kSecondaryColor;
//     switch (entry.value) {
//       case SeatType.available:
//         icon = Icons.check_box_outline_blank_outlined;
//         break;
//       case SeatType.selected:
//         icon = Icons.check_box;
//         break;
//       default:
//         icon = Icons.disabled_by_default_rounded;
//         color = Colors.grey;
//         break;
//     }
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(kBorderRadius * .2),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             widget.data[group]![entry.key] =
//                 switchSheetType(widget.data[group]![entry.key]);
//           },
//           child: SizedBox(
//             width: 30,
//             height: 30,
//             child: Icon(icon, color: color),
//           ),
//         ),
//       ),
//     );
//   }

//   Column buildExecutiveRowLabel() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 30),
//         ...List.generate(
//             10,
//             (index) => SizedBox(
//                   width: 30,
//                   height: 30,
//                   child: Center(
//                     child: Text((index + 1).toString(),
//                         textAlign: TextAlign.center),
//                   ),
//                 ))
//       ],
//     );
//   }
// }
