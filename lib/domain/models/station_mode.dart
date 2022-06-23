import 'package:cloud_firestore/cloud_firestore.dart';

class TrainStation {
  static const String nameFeild = 'name';

  String? id;
  String? name;

  TrainStation({this.id, this.name});

  /// TrainStation data from [FirebaseFirestore] Server
  factory TrainStation.fromMap(DocumentSnapshot map) => TrainStation(
        id: map.id,
        name: map[nameFeild],
      );

  /// TrainStation data to [FirebaseFirestore] Server
  Map<String, dynamic> toMap() => {
        nameFeild: name,
      };
}
