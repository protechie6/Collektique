import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/notification_model.dart';

class UserNotificatonService {
  final String userId;

  UserNotificatonService({
    required this.userId,
  });

  final CollectionReference notifications =
      FirebaseFirestore.instance.collection("Notifications");

// get user notifications
  Stream<QuerySnapshot> userNotifications() {
    return notifications.where("receiverId", isEqualTo: userId).snapshots();
  }

  Stream<QuerySnapshot> userNotificationsAlert() {
    return notifications
        .where("receiverId", isEqualTo: userId)
        .where("isSeen", isEqualTo: "no")
        .snapshots();
  }

//send user notifications
  Future sendNotification(String receiverId, String title, String content, String type) async {
    String docId = notifications.doc().id;
    NotificationModel notification = NotificationModel(title: title, content: content, date: DateTime.now().millisecondsSinceEpoch.toString(),
                   type: type, receiverId: receiverId, id: docId, isSeen: 'no');
    final docRef = notifications
        .withConverter(
          fromFirestore: NotificationModel.fromFirestore,
          toFirestore: (NotificationModel data, options) => data.toFirestore(),
        )
        .doc(docId);

    return await docRef.set(notification);
  }

  Future isSeen(String docId) async {
    final docRef = notifications.doc(docId);
    return await docRef.update({"isSeen": "yes"});
  }
}
