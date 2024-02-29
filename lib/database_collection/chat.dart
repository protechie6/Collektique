import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:watch_vault/utils/app_constants.dart';
import 'package:watch_vault/models/message_model.dart';
import 'package:watch_vault/models/chat_item_model.dart';

class ChatService {
  final String userId;

  ChatService({
    required this.userId,
  });

  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection("Messaging");

  Stream<QuerySnapshot> getChats() {
    return chatsCollection.doc(userId).collection("Chats").snapshots();
  }

  void sendMessage(String content, String receiver, String messageType) {

final batch = FirebaseFirestore.instance.batch();

// the sender's chat
    ChatItemModel chat = ChatItemModel(
        id: receiver,
        lastMessage: content,
        time: DateTime.now().millisecondsSinceEpoch.toString(),);

    final docRef = chatsCollection
        .doc(userId)
        .collection("Chats")
        .withConverter(
          fromFirestore: ChatItemModel.fromFirestore,
          toFirestore: (ChatItemModel data, options) => data.toFirestore(),
        )
        .doc(receiver);
        batch.set(docRef, chat);

// the receiver's chat
        ChatItemModel chat2 = ChatItemModel(
        id: userId,
        lastMessage: content,
        time: DateTime.now().millisecondsSinceEpoch.toString(),);

    final docRef2 = chatsCollection
        .doc(receiver)
        .collection("Chats")
        .withConverter(
          fromFirestore: ChatItemModel.fromFirestore,
          toFirestore: (ChatItemModel data, options) => data.toFirestore(),
        )
        .doc(userId);
        batch.set(docRef2, chat2);
        
    // the message
    String docId = chatsCollection.doc().id;

    if(messageType==AppConstants.image){
      uploadImage(content,docId,receiver);
    }

    MessageModel msgModel = MessageModel(
      content: content,
      sender: userId,
      receiver: receiver,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      messageId: docId, 
      messageType: messageType,
    );

// the sender's endpoint
    final docRef3 = chatsCollection
        .doc(userId)
        .collection(receiver)
        .withConverter(
          fromFirestore: MessageModel.fromFirestore,
          toFirestore: (MessageModel data, options) => data.toFirestore(),
        )
        .doc(docId);
         batch.set(docRef3, msgModel);

// the receiver's endpoint
      final docRef4 = chatsCollection
          .doc(receiver)
          .collection(userId)
          .withConverter(
            fromFirestore: MessageModel.fromFirestore,
            toFirestore: (MessageModel data, options) => data.toFirestore(),
          )
          .doc(docId);
          batch.set(docRef4, msgModel);

    batch.commit();
}

  Stream<QuerySnapshot> getMessages(String receiver) {
    return chatsCollection
        .doc(userId)
        .collection(receiver)
        .orderBy("time", descending: false)
        .snapshots();
  }

   void uploadImage(String image, String docId, String receiver) {
    String filePath =
          "$userId/itemImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      final metadata = SettableMetadata(contentType: "image/jpeg");
      UploadTask uploadTask = storageRef.putFile(File(image), metadata);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          // Handle successful uploads on complete
          String downloadUrl = await storageRef.getDownloadURL();
          
final batch = FirebaseFirestore.instance.batch();
// the receiver's endpoint
          final docRef = chatsCollection
          .doc(receiver)
          .collection(userId)
          .doc(docId);
        batch.update(docRef, {"content":downloadUrl});

// the sender's endpoint
          final docRef2 = chatsCollection
        .doc(userId)
        .collection(receiver)
        .doc(docId);
        batch.update(docRef2, {"content":downloadUrl});

        batch.commit();
        }
      });
  }
}
