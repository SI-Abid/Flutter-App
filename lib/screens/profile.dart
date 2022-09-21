import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/imageupload.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel? user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User? user = FirebaseAuth.instance.currentUser;

  UserModel? user = UserModel();

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final userPhoto = GestureDetector(
      onTap: (() => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ImageUpload(userId: user!.uid,),))),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(user!.photoUrl ??
            'https://www.kindpng.com/picc/m/451-4517876_default-profile-hd-png-download.png'),
      ),
    );

    final userName = Text(
      user!.name!,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

    final userEmail = Text(
      user!.email!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    final userPhone = Text(
      user!.phone!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    final userRole = Text(
      user!.role!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    final userId = Text(
      user!.id!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    // if verified show verified icon
    // else show verify button
    final userVerified = user!.verified!
        ? const Icon(
            Icons.verified,
            color: Colors.green,
          )
        : ElevatedButton(
            onPressed: sendVerifyLink,
            child: const Text('Verify'),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            userPhoto,
            const SizedBox(height: 20),
            userName,
            const SizedBox(height: 20),
            userEmail,
            const SizedBox(height: 20),
            userPhone,
            const SizedBox(height: 20),
            userRole,
            const SizedBox(height: 20),
            userId,
            const SizedBox(height: 20),
            userVerified,
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  sendVerifyLink() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    Fluttertoast.showToast(
        msg: "Verification link sent to your email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}
