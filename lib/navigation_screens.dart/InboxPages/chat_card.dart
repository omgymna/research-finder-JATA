import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../controller/chat_controller.dart';
import '../../main.dart';
import '../../models/faculty_model.dart';
import '../../models/message_model.dart';

class ChatCard extends StatefulWidget {

  final FacultyModel user;

  const ChatCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {

  MessageModel? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(horizontal: w*.03, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: (){
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(user: widget.user,)));
        },
        child: StreamBuilder(
            stream: ChatController.getLastMessage(widget.user.sId!),
            builder: (context, snapshot){
              final data = snapshot.data?.docs;
              final _messagesList = data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
              if(_messagesList.isNotEmpty) _message = _messagesList[0];
              return ListTile(
                leading: GestureDetector(
                  onTap: (){
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => ProfileDialog(user: widget.user,)
                    // );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(h*.3),
                    child: CachedNetworkImage(
                      width: h *.055,
                      height: h*.055,
                      fit: BoxFit.cover,
                      imageUrl: '${APIs.filesBaseUrl}/${widget.user.profilePic!}',
                      placeholder: (context, url) => CircleAvatar(
                        radius: 25,
                        child: Icon(CupertinoIcons.person),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: 25,
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                ),
                title: Text(widget.user.name!),
                subtitle: Text( _message != null ? _message!.messageType == Type.image ? 'Photo' : _message!.message :  widget.user.university!, maxLines: 1,
                  style: TextStyle(color: Colors.black54),
                ),
                // trailing:
                // _message == null
                //     ? null
                //     : _message!.readTime.isEmpty && _message!.senderId != APIs.user.uid
                //     ? Container(
                //   width: 15,
                //   height: 15,
                //   decoration: BoxDecoration(
                //     color: Colors.greenAccent.shade400,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // )
                //     : Text(DateHelper.getLastMessageTime(context: context, time: _message!.sendingTime), style: TextStyle(color: Colors.black54),),
              );
            }),
      ),
    );
  }
}
