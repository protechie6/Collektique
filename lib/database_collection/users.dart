
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firebase_user.dart';

class Users{
//userId
  final String userId;

  Users({
    required this.userId,
  });

  //collection Reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("Users");

  Stream<QuerySnapshot> get allUsers {
    return usersCollection.snapshots();
  }

  Future insertUserData(UserData userData) async {
    final docRef = usersCollection
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData data, options) => data.toFirestore(),
        )
        .doc(userId);

    return await docRef.set(userData);
  }

  Future updateUserData(String field, Object value) async {
    final docRef = usersCollection.doc(userId);
    return await docRef.update({field: value});
  }
  
  Future<DocumentSnapshot> get userData{
    return usersCollection.doc(userId).get();
  }

  UserData _currentUserDataModel(DocumentSnapshot snapshot){
    return UserData.fromDocument(snapshot);
  }

// get a user data
  Stream<UserData> get currentUserData {
  
   return usersCollection.doc(userId).snapshots()
    .map(_currentUserDataModel);
    
  }

  // query database
  Stream<QuerySnapshot> queryUserDatabase(String field, String value) {
    return usersCollection.orderBy('search')
      .startAt([value])
      .endAt(['$value\uf8ff']).snapshots();
  }

  Stream<QuerySnapshot> get allInbox{
    return FirebaseFirestore.instance.collection("UserInbox").where("receiverId",isEqualTo: userId).snapshots();
  }
}
