import 'package:cloud_firestore/cloud_firestore.dart';

class Train {
  static const String idFeild = 'train_id';

  static const String nameFeild = 'name';
  static const String typeFeild = 'type';

  final String id;
  String? name;
  String? type;

  Train({required this.id, this.name, this.type});

  /// TrainModel Data from [FirebaseFirestore] Server.
  factory Train.fromMap(DocumentSnapshot map) => Train(
        id: map.id,
        name: map[nameFeild],
        type: map[typeFeild],
      );

  /// TrainModel Data to [FirebaseFirestore] Server
  Map<String, dynamic> toMap() => {
        idFeild: id,
        nameFeild: name,
        typeFeild: type,
      };
}
