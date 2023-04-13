import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  String? name;
  String? username;
  String? adresse;
  String? phone;
  String? email;

  MyUser({
    this.username,
    this.uid,
    this.name,
    this.adresse,
    this.phone,
    this.email,
  });

  toJson() {
    return {
      "Uid": uid,
      "username": username,
      "name": name,
      "adresse": adresse,
      "phone": phone,
      "email": email,
    };
  }
}
