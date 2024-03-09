import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/components/chat_bubble.dart';
import 'package:firebase_chat/components/my_text_field.dart';
import 'package:firebase_chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    super.key, 
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){ //only send message if message is not empty
      await _chatService.sendMessage(
        widget.receiverUserID, _messageController.text);
      //clear the text controller once it's been sent
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
        backgroundColor: Color(0xFFA18C74) ,
        elevation: 0,
      ),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList()
          ),

          //user input
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      )
    );
  }
    //build message list

    Widget _buildMessageList(){ 
      return StreamBuilder(
        stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid), 
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Text('Error ${snapshot.error}');
          } 
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          } 
          
          return ListView(
            children: snapshot.data!.docs
            .map((document) => _buildMessageItem(document))
            .toList(),
          );
        },
      );
    }


    //build message item
    Widget _buildMessageItem(DocumentSnapshot document){
       Map<String, dynamic> data = document.data() as Map<String, dynamic>; 
    
      //align the messages to the right if the sender is the current user, otherwise to the left 
      var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight 
        : Alignment.centerLeft; 
        
      return Container(
        alignment: alignment, 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (
              data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
            mainAxisAlignment: 
            (data['senderId'] == _firebaseAuth.currentUser!.uid )
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,

            children: [
              Text(data['senderEmail']), 
              const SizedBox(height: 5,),
              ChatBubble(message: data['message'])
            ],
          ),
        ),
      );
    }
    //build message input
    Widget _buildMessageInput(){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children:[
            //text field
            Expanded(
              child: MyTextField(
                controller: _messageController, 
                hintText: "Enter Message", 
                obscureText: false)
            ), 
              
            //send button

            ElevatedButton(
              onPressed: sendMessage,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xAA597E52), // <-- Button color
                foregroundColor: Colors.black, // <-- Splash color
              ),
              child: Icon(
                Icons.arrow_upward, color: Colors.white, size: 25
              ),
            ),
          ],
        ),
      );
    } 
    
}

