import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  String sender;
  String receiver;
  String time;
  String messageId;
  String messageType;

  MessageModel({
    required this.content,
    required this.sender,
    required this.receiver,
    required this.time,
    required this.messageId,
    required this.messageType,
  });

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MessageModel(
      content: data?['content'],
      sender: data?['sender'],
      receiver: data?['receiver'],
      time: data?['time'],
      messageId: data?['messageId'],
      messageType: data?['messageType'],
    );
  }

  factory MessageModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String content = documentSnapshot.get("content");
    String sender = documentSnapshot.get("sender");
    String receiver = documentSnapshot.get("receiver");
    String time = documentSnapshot.get("time");
    String messageId = documentSnapshot.get("messageId");
    String messageType = documentSnapshot.get("messageType");
    return MessageModel(
        content: content,
        sender: sender,
        receiver: receiver,
        time: time,
        messageId: messageId,
        messageType: messageType);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "content": content,
      "sender": sender,
      "receiver": receiver,
      "time": time,
      "messageId": messageId,
      "messageType": messageType,
    };
  }
}
