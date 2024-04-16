import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String? messageId;
  String? senderId;
  String? receiverId;
  String? message;
  Timestamp? timestamp;

  ChatMessage({this.messageId, this.senderId, this.receiverId, this.message, this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['messageId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
