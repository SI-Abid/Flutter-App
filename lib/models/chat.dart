import 'package:flutter/material.dart';

class ChatModel extends StatefulWidget {
  const ChatModel({super.key});

  @override
  State<ChatModel> createState() => _ChatModelState();
}

class _ChatModelState extends State<ChatModel> {
  @override
  Widget build(BuildContext context) {
    // a list item for a message
    const message = ListTile(
      title:Text('Message'),
      subtitle: Text('Sender'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
      ),
      trailing: Text('Time'),
    );
    return message;
  }
}