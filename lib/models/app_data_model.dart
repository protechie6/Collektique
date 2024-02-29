import 'package:cloud_firestore/cloud_firestore.dart';

class AppDataModel {
  String appStoreLink;
  String playStoreLink;
  String currentVersion;
  bool newUpdate;
  String releaseDate;
  String updateLink;

  AppDataModel({
    required this.appStoreLink,
    required this.playStoreLink,
    required this.currentVersion,
    required this.newUpdate,
    required this.releaseDate,
    required this.updateLink,
  });

  factory AppDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppDataModel(
      appStoreLink: data?['appStoreLink'],
      playStoreLink: data?['playStoreLink'],
      currentVersion: data?['currentVersion'],
      newUpdate: data?['newUpdate'],
      releaseDate: data?['releaseDate'],
      updateLink: data?['updateLink'],
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      "appStoreLink": appStoreLink,
      "playStoreLink": playStoreLink,
      "currentVersion": currentVersion,
      "newUpdate": newUpdate,
      "releaseDate": releaseDate,
      "updateLink": updateLink,
    };
  }
}
