import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItemModel{
  
  String id;
  String lastMessage;
  String time;

  ChatItemModel({ 
  required this.id, 
  required this.lastMessage, 
  required this.time,});

  factory ChatItemModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ChatItemModel(
      id: data?['id'],
      lastMessage: data?['lastMessage'],
      time: data?['time'],
    );
  }

  factory ChatItemModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String id = documentSnapshot.get("id");
    String lastMessage = documentSnapshot.get("lastMessage");
    String time = documentSnapshot.get("time");
     return ChatItemModel(id: id, lastMessage: lastMessage, time: time,);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
       "lastMessage": lastMessage,
       "time": time,
    };
  }
}