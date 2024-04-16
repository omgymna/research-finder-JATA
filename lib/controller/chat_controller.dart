import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../models/faculty_model.dart';
import '../models/message_model.dart';

class ChatController{

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<void> createUser(FacultyModel user) async{
    await fireStore.collection('users').doc(user.sId).set(user.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getConnectedUsersId(){
    return fireStore.collection('users').doc(currentUser!.sId).collection('connections').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(List<String> userIds){
    return fireStore.collection('users').where('id', whereIn: userIds.isEmpty ? [''] : userIds).snapshots();
  }

  static Future<void> sendFirstMessage(String chatUserId, String message, Type type) async{
    await fireStore.collection('users').doc(chatUserId).collection('connections').doc(currentUser!.sId).set({}).then((value) => sendMessage(chatUserId, message, type));
  }

  static String getConversationId(String id) => currentUser!.sId.hashCode <= id.hashCode ? '${currentUser!.sId}_$id' : '${id}_${currentUser!.sId}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String id){
    return fireStore.collection('chats/${getConversationId(id)}/messages/').orderBy('sendingTime', descending: true).snapshots();
  }

  static Future<void> sendMessage(String chatUserId, String message, Type type) async{

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModel msg = MessageModel(
        message: message,
        sendingTime: time,
        messageType: type,
        senderId: currentUser!.sId!,
        readTime: '',
        receiverId: chatUserId
    );
    final ref = fireStore.collection('chats/${getConversationId(chatUserId)}/messages/');
    await ref.doc(time).set(msg.toJson());
    // await ref.doc(time).set(msg.toJson()).then((value)=>sendPushNotification(chatUser, type == Type.text ? message : 'Photo'));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(String chatUserId){
    return fireStore.collection('chats/${getConversationId(chatUserId)}/messages/').orderBy('sendingTime', descending: true).limit(1).snapshots();
  }

  static Future<void> addChatUser(String id) async{
    await fireStore.collection('chat_users').doc(currentUser!.sId!).collection('users').doc(id).set({});
    await fireStore.collection('chat_users').doc(id).collection('users').doc(currentUser!.sId!).set({});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatUsers(){
    return fireStore.collection('chat_users').doc(currentUser!.sId!).collection('users').snapshots();
  }

}
