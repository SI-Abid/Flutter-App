import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? id;
  String? photoUrl;
  String? phone;
  String? role;
  bool? verified;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.id,
    this.photoUrl,
    this.phone,
    this.role,
    this.verified,
  });

  // getting from server
  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      name: data?['name'],
      email: data?['email'],
      id: data?['id'],
      photoUrl: data?['photoUrl'],
      phone: data?['phone'],
      role: data?['role'],
      verified: data?['verified'],
    );
  }

  // sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
      'phone': phone,
      'role': role,
      'verified': verified,
    };
  }

}
