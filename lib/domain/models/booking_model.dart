import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_smartapp/domain/models/seat_model.dart';

class TrainBooking {
  // static const String dateFeild = 'date';
  static const String arrivalTimeFeild = 'arrivalTime';
  static const String seatFeild = 'seat';
  static const String routeFeild = 'route';

  String? id;
  // DateTime date;
  DateTime time;
  List<String> seats;
  String route;

  TrainBooking({
    this.id,
    // required this.date,
    required this.time,
    required this.seats,
    required this.route,
  });

  // TrainBooking Data from Server
  factory TrainBooking.fromMap(DocumentSnapshot map) => TrainBooking(
        id: map.id,
        // date: DateTime.fromMillisecondsSinceEpoch(map[dateFeild]),
        time: DateTime.fromMillisecondsSinceEpoch(map[arrivalTimeFeild]),
        seats: map[seatFeild].map<String>((e) => e.toString()).toList(),
        route: map[routeFeild],
      );

  // TrainBooking Data to Server
  Map<String, dynamic> toMap() => {
        // dateFeild: date.millisecondsSinceEpoch,
        arrivalTimeFeild: time.millisecondsSinceEpoch,
        seatFeild: seats.map((e) => e).toList(),
        routeFeild: route,
      };
}
