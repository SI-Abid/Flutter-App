import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/api/firebase_options.dart';
import 'package:flutter_app/models/user.dart';

class FirebaseApi {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static bool get isSignedIn => currentUser != null;
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Stream<List<UserModel>> get userStream =>
      FirebaseFirestore.instance.collection('users').snapshots().transform(
        StreamTransformer.fromHandlers(
          handleData:
              (QuerySnapshot snapshot, EventSink<List<UserModel>> sink) {
            final users = snapshot.docs
                .map((doc) =>
                    UserModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            sink.add(users);
          },
        ),
      );

  // firebase storage reference
  static Reference storageRef(String path) =>
      FirebaseStorage.instance.ref(path);

  // firebase firestore document reference
  static DocumentReference<dynamic> ref(String collection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(currentUser!.uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>),
          toFirestore: (user, _) => user.toJson(),
        );
  }
}
