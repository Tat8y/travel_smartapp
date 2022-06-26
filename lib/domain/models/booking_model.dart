import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';
import 'package:travel_smartapp/domain/models/support_models/travel_route.dart';
import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';

class TrainBooking {
  static const String dateFeild = 'date';
  static const String arrivalTimeFeild = 'arrivalTime';
  static const String seatFeild = 'seat';
  static const String routeFeild = 'route';

  String? id;
  DateTime date;
  DateTime arrivalTime;
  List<Seat> seats;
  String route;

  TrainBooking({
    this.id,
    required this.date,
    required this.arrivalTime,
    required this.seats,
    required this.route,
  });

  // TrainBooking Data from Server
  factory TrainBooking.fromMap(DocumentSnapshot map) => TrainBooking(
        id: map.id,
        date: DateTime.fromMillisecondsSinceEpoch(map[dateFeild]),
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(map[arrivalTimeFeild]),
        seats: [],
        route: map[routeFeild],
      );

  // TrainBooking Data to Server
  Map<String, dynamic> toMap() => {
        dateFeild: date.millisecondsSinceEpoch,
        arrivalTimeFeild: arrivalTime.millisecondsSinceEpoch,
        seatFeild: seats.map((e) => e.id).toList(),
        routeFeild: route,
      };
}
