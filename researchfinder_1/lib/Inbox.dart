import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        "sender": "Researcher A",
        "message": "Message from Researcher A",
        "profilePic": "assets/profile_a.png", 
      },
      {
        "sender": "Researcher B",
        "message": "Message from Researcher B",
        "profilePic": "assets/profile_b.png",
      },
      {
        "sender": "Researcher C",
        "message": "Message from Researcher C",
        "profilePic": "assets/profile_c.png",
      },
    ];

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(message["profilePic"]),
            ),
            title: Text(message["sender"]),
            subtitle: Text(message["message"]),
            onTap: () {
            },
          ),
        );
      },
    );
  }
}
