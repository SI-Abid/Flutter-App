import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/imageupload.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(loggedInUser.photoUrl == null
                      ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                      : loggedInUser.photoUrl!),
                ),
                const Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: InkWell(
                    onTap: null,
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ImageUpload(userId: user!.uid)),
                    //   );
                    // },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.teal,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Name ${loggedInUser.name}',
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Email ${loggedInUser.email}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Phone ${loggedInUser.phone}',
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // if verified show verified else show verify button
          loggedInUser.verified != null && loggedInUser.verified == true
              ? const Icon(
                  Icons.verified,
                  color: Colors.green,
                )
              : ElevatedButton(
                  onPressed: sendVerifyLink,
                  child: const Text('Verify'),
                ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(user: loggedInUser)),
            );
          }
        },
      ),
    );
  }

  sendVerifyLink() async {
    if (user!.emailVerified) {
      Fluttertoast.showToast(
          msg: 'Email already verified',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      await user!.sendEmailVerification();
      Fluttertoast.showToast(
          msg: "Verification link sent to your email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
      // Fluttertoast.showToast(msg: 'Verification Link Sent');
    }
    // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }
}
