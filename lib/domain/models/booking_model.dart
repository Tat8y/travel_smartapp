import 'package:cloud_firestore/cloud_firestore.dart';

class TrainBooking {
  static const String arrivalTimeFeild = 'arrivalTime';
  static const String seatFeild = 'seat';
  static const String scheduleFeild = 'schedule_id';
  static const String fromFeild = 'from';
  static const String toFeild = 'to';

  String? id;
  DateTime time;
  List<String> seats;
  String schedule;
  String from;
  String to;

  TrainBooking({
    this.id,
    required this.time,
    required this.seats,
    required this.schedule,
    required this.from,
    required this.to,
  });

  factory TrainBooking.fromMap(DocumentSnapshot map) => TrainBooking(
        id: map.id,
        time: DateTime.fromMillisecondsSinceEpoch(map[arrivalTimeFeild]),
        seats: map[seatFeild].map<String>((e) => e.toString()).toList(),
        schedule: map[scheduleFeild],
        from: map[fromFeild],
        to: map[toFeild],
      );

  Map<String, dynamic> toMap() => {
        arrivalTimeFeild: time.millisecondsSinceEpoch,
        seatFeild: seats.map((e) => e).toList(),
        scheduleFeild: schedule,
        fromFeild: from,
        toFeild: to,
      };
}
