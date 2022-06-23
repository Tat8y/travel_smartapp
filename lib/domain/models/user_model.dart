import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  //String? points;

  UserModel({this.uid, this.email, this.firstName, this.secondName});

//UserModel DATA FROM SERVER
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
      uid: map.id,
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

//SENDING DATA TO OUR SERVER
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
