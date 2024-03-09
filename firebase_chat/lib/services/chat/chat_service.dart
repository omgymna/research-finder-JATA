import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/model/message.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //send message

  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();


    //create a new message
    Message newMessage = Message( 
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      receiverId: receiverId, 
      timestamp: timestamp, 
      message: message,
    );

    //construct chat room id from current user and receiver user id(sorted)

    List<String> ids = [currentUserId, receiverId]; 
    ids.sort();   //sort the ids
    String chatRoomId = ids.join( "_"); //combine the ids into a single string to user as chatroom id

    //add new message to database
    await _fireStore
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('messages')
      .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){

    ////construct chat room id from user ids (sorted to ensure it matches the id userd when sending
  
    List<String> ids =[userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join( "_"); //combine the ids into a single string to user as chatroom id


      return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp',descending:false)
        .snapshots();
  }
}