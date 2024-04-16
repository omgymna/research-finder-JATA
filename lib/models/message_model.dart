class MessageModel {
  MessageModel({
    required this.message,
    required this.sendingTime,
    required this.messageType,
    required this.senderId,
    required this.readTime,
    required this.receiverId,
  });
  late String message;
  late String sendingTime;
  late Type messageType;
  late String senderId;
  late String readTime;
  late String receiverId;

  MessageModel.fromJson(Map<String, dynamic> json){
    message = json['message'].toString();
    sendingTime = json['sendingTime'].toString();
    messageType = json['messageType'].toString() == Type.image.name ? Type.image : Type.text;
    senderId = json['senderId'].toString();
    readTime = json['readTime'].toString();
    receiverId = json['receiverId'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['sendingTime'] = sendingTime;
    data['messageType'] = messageType.name;
    data['senderId'] = senderId;
    data['readTime'] = readTime;
    data['receiverId'] = receiverId;
    return data;
  }
}

enum Type{text, image}
