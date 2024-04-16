import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final DateTime dateTime;
  final VoidCallback onPress;
  ChatRoom(
      {super.key,
      required this.title,
        required this.id,
      required this.subtitle,
      required this.dateTime,
      required this.image,
      required this.onPress});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPress,
        child: Card(
            elevation: 0,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 6),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(widget.image),
                radius: 25,
              ),
              title: Text(widget.title),
              subtitle: Text(widget.subtitle),
              trailing: Text(
                '${widget.dateTime.hour}:${widget.dateTime.minute}',
              ),
            )));
  }
}
