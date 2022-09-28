import 'package:flutter/material.dart';
import 'package:flutter_app/models/chat.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/profile.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

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
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return const ChatModel();
        },
      ),
      // bottom button for sending messages
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.send_rounded),
      ),
    );
  }
}
