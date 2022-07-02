import 'package:travel_smartapp/domain/models/train_schedule_mode.dart';

class TravelRoute {
  static const String fromFeild = 'from';
  static const String toFeild = 'to';
  static const String dateFeild = 'date';
  static const String scheduleIDFeild = 'schedule_id';

  final String from;
  final String to;

  final TrainSchedule schedule;

  TravelRoute({
    required this.from,
    required this.to,
    required this.schedule,
  });

  // // Travel Route Data to Map
  // Map<String, dynamic> toMap() => {
  //       fromFeild: from,
  //       toFeild: to,
  //       dateFeild: date.millisecondsSinceEpoch,
  //       scheduleIDFeild: schedule
  //     };

  // // Travel Route Data from Map
  // static TravelRoute fromMap(map) => TravelRoute(
  //     from: map['from'],
  //     to: map['to'],
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date']),
  //     schedule: map[scheduleIDFeild]);
}
