import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/chat.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? user;
  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  late UserModel user;
  bool isLoading = true;

  Future<void> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt('visited') ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCount();
    if (widget.user != null) {
      user = widget.user as UserModel;
      isLoading = false;
      return;
    }
    FirebaseApi.ref("users").get().then((value) {
      setState(() {
        user = value.data()!;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
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
                if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                }
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(user: user)),
                  );
                }
              },
            ),
            appBar: AppBar(
              title: const Text('Welcome'),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 250.0,
                      width: 350.0,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Logged in as ${user.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Role: ${user.role}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ActionChip(
                      label: const Text('Logout'),
                      onPressed: () => logOut(context),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Visited $count times',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> logOut(BuildContext context) async {
    FirebaseApi.signOut().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }
}
