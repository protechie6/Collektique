import 'package:cloud_firestore/cloud_firestore.dart';

class InboxModel {
  
  String content;
  String date;
  String receiverId;
  String id;
  String isSeen;

  InboxModel({
    required this.content,
    required this.date,
    required this.receiverId,
    required this.id,
    required this.isSeen,
  });

  factory InboxModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return InboxModel(
      content: data?['content'],
      date: data?['date'],
      receiverId: data?['receiverId'],
      id: data?['id'],
      isSeen: data?['isSeen'],
    );
  }

  factory InboxModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String content = documentSnapshot.get("content");
    String date = documentSnapshot.get("date");
    String receiverId = documentSnapshot.get("receiverId");
    String id = documentSnapshot.get("id");
    String isSeen = documentSnapshot.get("isSeen");

    return InboxModel(
      content: content,
      date: date,
      receiverId: receiverId,
      id: id,
      isSeen: isSeen,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "content": content,
      "date": date,
      "receiverId": receiverId,
      "id": id,
      "isSeen": isSeen,
    };
  }
}
