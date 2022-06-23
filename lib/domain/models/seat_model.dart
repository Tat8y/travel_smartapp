import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_smartapp/enums/train/seat.dart';

class Seat {
  static const String seatTypeFeild = 'seatType';
  static const String bookingIDFeild = 'bookingID';

  String? id;
  SeatType? seatType;
  String? bookingID;

  Seat({this.id, this.seatType, this.bookingID});

  factory Seat.fromMap(QueryDocumentSnapshot map) => Seat(
        id: map.id,
        seatType: seatTypeFromStr[map[seatTypeFeild]] ?? SeatType.unavailable,
        bookingID: map[bookingIDFeild],
      );

  Map<String, dynamic> toMap() => {
        seatTypeFeild: seatTypeToStr[seatType],
        bookingIDFeild: bookingID,
      };
}
