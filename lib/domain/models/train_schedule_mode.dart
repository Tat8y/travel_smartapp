import 'package:cloud_firestore/cloud_firestore.dart';

class TrainSchedule {
  static const String trainFeild = 'train_id';
  static const String stationFeild = 'station_id';
  static const String arrivalTimeFeild = 'arrival_time';

  final String id;
  final String train;
  final String station;
  final DateTime arrivalTime;

  TrainSchedule({
    required this.id,
    required this.train,
    required this.station,
    required this.arrivalTime,
  });

  static TrainSchedule fromMap(DocumentSnapshot doc) => TrainSchedule(
        id: doc.id,
        train: doc[trainFeild] as String,
        station: doc[stationFeild] as String,
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(doc[arrivalTimeFeild]),
      );

  Map<String, dynamic> toMap() => {
        trainFeild: train,
        stationFeild: station,
        arrivalTimeFeild: arrivalTime.millisecondsSinceEpoch,
      };
}
