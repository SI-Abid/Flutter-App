import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String id;
  String? imageUrl;
  String phone;
  String role;
  bool verified;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.id,
    this.imageUrl,
    required this.phone,
    required this.role,
    required this.verified,
  });

  // getting from server
  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      id: data['id'],
      imageUrl: data['imageUrl'],
      phone: data['phone'],
      role: data['role'],
      verified: data['verified'],
    );
  }

  // sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'id': id,
      'imageUrl': imageUrl,
      'phone': phone,
      'role': role,
      'verified': verified,
    };
  }
}
