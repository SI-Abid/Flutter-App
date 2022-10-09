import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';

class ChatModel extends StatelessWidget {
  final UserModel user;
  const ChatModel({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // a list item for a message
    return ListTile(
      title: Text(user.name),
      subtitle: const Text('Hello'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.imageUrl),
      ),
      trailing: const Text('12:00'),
    );
  }
}

//=========================Chat Screen Header part==============================================

class ChatHeader extends StatelessWidget {
  final List<UserModel> users;
  const ChatHeader({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users.length+1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: const CircleAvatar(
                  radius: 26,
                  child: Icon(Icons.search),
                ),
              );
            } else {
              final user = users[index-1];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

//=========================Chat Screen Body part==============================================

class ChatBody extends StatelessWidget {
  final List<UserModel> users;
  const ChatBody({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    // a list item for a message
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ChatModel(user: users[index]);
          },
        ),
      ),
    );
  }
}

// ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final user = users[index];

//                   return ChatModel(user: user);
//                 },
//                 itemCount: users.length,
//               ),