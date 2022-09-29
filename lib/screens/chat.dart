// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase.dart';
import 'package:flutter_app/models/chat.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/profile.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: const Text('Chat'),
        // add search icon
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          // 3 dot menu
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('New Group'),
              ),
              const PopupMenuItem(
                child: Text('New Broadcast'),
              ),
              const PopupMenuItem(
                child: Text('WhatsApp Web'),
              ),
              const PopupMenuItem(
                child: Text('Starred Messages'),
              ),
              const PopupMenuItem(
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      // list builder for messages
      body: SafeArea(
          child: StreamBuilder<List<UserModel>>(
              stream: FirebaseApi.userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                final users = snapshot.data as List<UserModel>;
                if (users.isEmpty) {
                  return const Center(child: Text('No Data'));
                }
                return Column(
                  children: [
                    ChatHeader(users: users),
                    ChatBody(users: users),
                  ],
                );
              })),

      // bottom button for sending messages
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.send_rounded),
      ),
    );
  }

  Widget buildText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
