import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String content;
  String date;
  String type;
  String receiverId;
  String id;
  String isSeen;

  NotificationModel({
    required this.title,
    required this.content,
    required this.date,
    required this.type,
    required this.receiverId,
    required this.id,
    required this.isSeen,
  });

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotificationModel(
      title: data?['title'],
      content: data?['content'],
      date: data?['date'],
      type: data?['type'],
      receiverId: data?['receiverId'],
      id: data?['id'],
      isSeen: data?['isSeen'],
    );
  }

  factory NotificationModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String title = documentSnapshot.get("title");
    String content = documentSnapshot.get("content");
    String date = documentSnapshot.get("date");
    String type = documentSnapshot.get("type");
    String receiverId = documentSnapshot.get("receiverId");
    String id = documentSnapshot.get("id");
    String isSeen = documentSnapshot.get("isSeen");

    return NotificationModel(
      title: title,
      content: content,
      date: date,
      type: type,
      receiverId: receiverId,
      id: id,
      isSeen: isSeen,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "content": content,
      "date": date,
      "type": type,
      "receiverId": receiverId,
      "id": id,
      "isSeen": isSeen,
    };
  }
}
