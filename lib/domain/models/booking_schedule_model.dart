import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSchedule {
  static const String trainIDFeild = 'trainID';
  static const String depatureFeild = 'depature';
  static const String destinationFeild = 'destination';
  static const String depatureTimeFeild = 'depatureTime';
  static const String destinationTimeFeild = 'destinationTime';

  String? id;
  String? trainID;
  String? depature;
  String? destination;
  DateTime? depatureTime;
  DateTime? destinationTime;

  BookingSchedule({
    this.id,
    this.trainID,
    this.depature,
    this.destination,
    this.depatureTime,
    this.destinationTime,
  });

  /// TrainSchedule Data from [FirebaseFirestore] Server.
  factory BookingSchedule.fromMap(DocumentSnapshot map) => BookingSchedule(
        id: map.id,
        trainID: map[trainIDFeild],
        depature: map[depatureFeild],
        destination: map[destinationFeild],
        depatureTime:
            DateTime.fromMillisecondsSinceEpoch(map[depatureTimeFeild]),
        destinationTime:
            DateTime.fromMillisecondsSinceEpoch(map[destinationTimeFeild]),
      );

  /// TrainSchedule Data to [FirebaseFirestore] Server
  Map<String, dynamic> toMap() => {
        trainIDFeild: trainID,
        depatureFeild: depature,
        destinationFeild: destination,
        depatureTimeFeild: depatureTime?.millisecondsSinceEpoch,
        destinationTimeFeild: destinationTime?.millisecondsSinceEpoch,
      };
}
