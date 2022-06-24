import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_smartapp/enums/train/seat.dart';

class Seat {
  static const String columnFeild = 'columnFeild';
  static const String rowFeild = 'rowFeild';
  static const String executiveFeild = 'executiveFeild';
  static const String seatTypeFeild = 'seatType';
  static const String bookingIDFeild = 'bookingID';

  final String? id;
  final String column;
  final int row;
  final int executive;
  final SeatType seatType;
  final String? bookingID;

  Seat({
    this.id,
    required this.column,
    required this.row,
    required this.executive,
    this.seatType = SeatType.available,
    this.bookingID,
  });

  factory Seat.fromMap(DocumentSnapshot map) => Seat(
        id: map.id,
        column: map[columnFeild] as String,
        row: map[rowFeild] as int,
        executive: map[executiveFeild] as int,
        bookingID: map[bookingIDFeild],
      );

  Map<String, dynamic> toMap() => {
        columnFeild: column,
        rowFeild: row,
        executiveFeild: executive,
        //seatTypeFeild: seatTypeToStr[seatType],
        bookingIDFeild: bookingID,
      };

  Seat update({SeatType? seatType, String? bookingID, int? executive}) => Seat(
        id: id,
        column: column,
        row: row,
        seatType: seatType ?? this.seatType,
        executive: executive ?? this.executive,
        bookingID: bookingID ?? this.bookingID,
      );
}

// Support Model
class SeatBox {
  final String column;
  final int row;
  final SeatType type;
  final int executive;

  SeatBox(
      {required this.column,
      required this.row,
      required this.type,
      required this.executive});

  SeatBox update({SeatType? type, int? executive}) => SeatBox(
        column: column,
        row: row,
        type: type ?? this.type,
        executive: executive ?? this.executive,
      );
}
