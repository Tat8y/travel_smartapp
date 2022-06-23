import 'package:cloud_firestore/cloud_firestore.dart';

class Train {
  static const String nameFeild = 'name';
  static const String typeFeild = 'type';

  String? id;
  String? name;
  String? type;

  Train({this.id, this.name, this.type});

  /// TrainModel Data from [FirebaseFirestore] Server.
  factory Train.fromMap(QueryDocumentSnapshot map) => Train(
        id: map.id,
        name: map[nameFeild],
        type: map[typeFeild],
      );

  /// TrainModel Data to [FirebaseFirestore] Server
  Map<String, dynamic> toMap() => {
        nameFeild: name,
        typeFeild: type,
      };
}
