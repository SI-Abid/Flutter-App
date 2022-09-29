import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/imageupload.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = FirebaseApi.currentUser as User;
  final ref = FirebaseApi.ref("users");
  late UserModel loggedInUser;
  bool isLoading = true;

  @override
  void initState() {
    // listen to changes in the user's email verification status
    super.initState();
    user.reload();
    ref.get().then((value) {
      setState(() {
        loggedInUser = value.data()!;
        if (!loggedInUser.verified && user.emailVerified) {
          loggedInUser.verified = true;
        }
        isLoading = false;
        // send to server
        ref.set(loggedInUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: NetworkImage(loggedInUser.imageUrl),
                      ),
                      Positioned(
                        bottom: 20.0,
                        right: 20.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageUpload(userId: user.uid)),
                            );
                          },
                          child: const Icon(
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
                  loggedInUser.name,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Email: ${loggedInUser.email}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'ID: ${loggedInUser.id}',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Phone: ${loggedInUser.phone}',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // if verified show verified else show verify button
                loggedInUser.verified == true
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
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: loggedInUser,
                      )),
            );
          }
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        user: loggedInUser,
                      )),
            );
          }
        },
      ),
    );
  }

  sendVerifyLink() async {
    user.reload();
    if (user.emailVerified) {
      setState(() {
        loggedInUser.verified = true;
        // update server
        ref.set(loggedInUser);
      });
      Fluttertoast.showToast(
          msg: 'Email verified',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      await user.sendEmailVerification();
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
}
