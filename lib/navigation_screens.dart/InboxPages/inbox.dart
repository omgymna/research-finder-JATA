import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:research_finder_jata/controller/chat_controller.dart';
import '../../main.dart';
import '../../models/message_model.dart';

class InboxPage extends StatefulWidget {
  final String id, name, profile;
  const InboxPage({super.key, required this.id, required this.name, required this.profile});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController _textController = TextEditingController();
  List<MessageModel> _messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 147, 167),
        leading: Row(
          children: [
            SizedBox(
              width: 24, //width of the IconButton 
              child: IconButton(
                padding: EdgeInsets
                    .zero, 
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 22,
                ),
              ),
            ),
            CircleAvatar(
              radius: 16,
              backgroundImage: CachedNetworkImageProvider(widget.profile),
            )
          ],
        ),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 20), 
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: ChatController.getMessages(widget.id),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Center(child: Text('Start Messaging!', style: TextStyle(fontSize: 16, color: Colors.black54),),);
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _messagesList = data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
                          if(_messagesList.isNotEmpty){
                            return ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.only(top: h*.02),
                                physics: BouncingScrollPhysics(),
                                itemCount: _messagesList.length,
                                itemBuilder: (context, index){
                                  return textContainer(
                                    _messagesList[index].senderId == currentUser!.sId ? Alignment.bottomRight : Alignment.bottomLeft,
                                    _messagesList[index].message,
                                    _messagesList[index].senderId == currentUser!.sId ? Colors.green[200]! : Colors.white60,
                                  );
                                }
                            );
                          }else{
                            return Center(child: Text('Start Messaging!', style: TextStyle(
                                fontSize: 16, color: Colors.black54),),);
                          }
                      }
                    }
                ),
              ),
              // Expanded(
              //   child: ListView(
              //
              //     children: [
              //       textContainer(
              //         Alignment.bottomLeft,
              //         'Hi, How are you?',
              //         Colors.white60,
              //       ),
              //       textContainer(
              //         Alignment.bottomRight,
              //         'Hey, I am good!',
              //         Colors.green[200]!,
              //       ),
              //       textContainer(
              //         Alignment.bottomRight,
              //         'How about you?',
              //         Colors.green[200]!,
              //       ),
              //       textContainer(
              //         Alignment.centerLeft,
              //         "I'm too good, Thank you!",
              //         Colors.white60,
              //       ),
              //       textContainer(
              //         Alignment.centerLeft,
              //         "By the way, did you finish that project we were discussing last time?",
              //         Colors.white60,
              //       ),
              //       textContainer(
              //         Alignment.centerRight,
              //         "Yes, I've completed it. Would you like to take a look at it?",
              //         Colors.green[200]!,
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          print('Sending message: ${_textController.text}');
                          if(_messagesList.isEmpty){
                            ChatController.sendFirstMessage(widget.id, _textController.text.trim(), Type.text);
                          }else{
                            ChatController.sendMessage(widget.id, _textController.text, Type.text);
                          }
                          ChatController.addChatUser(widget.id);
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.003,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textContainer(
    AlignmentGeometry align,
    String text,
    Color color,
  ) {
    return Align(
      alignment: align,
      child: Container(
        constraints: BoxConstraints(maxWidth: w / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
