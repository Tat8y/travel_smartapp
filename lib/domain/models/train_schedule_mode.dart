import 'package:cloud_firestore/cloud_firestore.dart';

class TrainSchedule {
  static const String trainFeild = 'train_id';
  static const String startStationFeild = 'start_station_id';
  static const String endStationFeild = 'end_station_id';
  static const String arrivalTimeFeild = 'arrival_time';

  String? id;
  final String train;
  final String startStation;
  final String endStation;

  final DateTime arrivalTime;

  TrainSchedule({
    this.id,
    required this.train,
    required this.startStation,
    required this.endStation,
    required this.arrivalTime,
  });

  static TrainSchedule fromMap(DocumentSnapshot doc) => TrainSchedule(
        id: doc.id,
        train: doc[trainFeild] as String,
        startStation: doc[startStationFeild] as String,
        endStation: doc[endStationFeild] as String,
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(doc[arrivalTimeFeild]),
      );

  Map<String, dynamic> toMap() => {
        trainFeild: train,
        startStationFeild: startStation,
        endStationFeild: endStation,
        arrivalTimeFeild: arrivalTime.millisecondsSinceEpoch,
      };
}
