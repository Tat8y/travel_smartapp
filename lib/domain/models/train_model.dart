import 'package:cloud_firestore/cloud_firestore.dart';

class Train {
  static const String idFeild = 'train_id';
  static const String nameFeild = 'name';
  static const String typeFeild = 'type';
  static const String seatsFeild = 'seats';

  final String id;
  String? name;
  String? type;
  List<String> seats;

  Train({required this.id, this.name, this.type, required this.seats});

  /// TrainModel Data from [FirebaseFirestore] Server.
  factory Train.fromMap(DocumentSnapshot map) => Train(
        id: map.id,
        name: map[nameFeild],
        type: map[typeFeild],
        seats: map[seatsFeild].map<String>((e) => e.toString()).toList(),
      );

  /// TrainModel Data to [FirebaseFirestore] Server
  Map<String, dynamic> toMap() => {
        idFeild: id,
        nameFeild: name,
        typeFeild: type,
        seatsFeild: seats,
      };

  Train copyWith({String? name, String? type, List<String>? seats}) => Train(
        id: id,
        seats: seats ?? this.seats,
        name: name ?? this.name,
        type: type ?? this.type,
      );
}
