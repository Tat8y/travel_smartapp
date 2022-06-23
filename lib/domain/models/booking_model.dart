import 'package:cloud_firestore/cloud_firestore.dart';

class TrainBooking {
  static const String dateFeild = 'date';
  static const String arrivalTimeFeild = 'arrivalTime';
  static const String seatFeild = 'seat';
  static const String routeFeild = 'route';

  String? id;
  DateTime? date;
  DateTime? arrivalTime;
  String? seat;
  String? route; // TODO: Route Model

  TrainBooking({
    this.id,
    this.date,
    this.arrivalTime,
    this.seat,
    this.route,
  });

  factory TrainBooking.fromMap(DocumentSnapshot map) => TrainBooking(
        id: map.id,
        date: DateTime.fromMillisecondsSinceEpoch(map[dateFeild]),
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(map[arrivalTimeFeild]),
        seat: map[seatFeild],
        route: map[routeFeild],
      );

  Map<String, dynamic> toMap() => {
        dateFeild: date?.millisecondsSinceEpoch,
        arrivalTimeFeild: arrivalTime?.millisecondsSinceEpoch,
        seatFeild: seat,
        routeFeild: route,
      };
}
