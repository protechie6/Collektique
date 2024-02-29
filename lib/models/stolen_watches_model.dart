import 'package:cloud_firestore/cloud_firestore.dart';

class StolenWatchModel {
  String brand;
  String model;
  String serialNumber;
  String year;
  String userId;
  String stolenWatchId;
  String dateStolen;
  List<String> images;

  StolenWatchModel({
    required this.brand,
    required this.model,
    required this.serialNumber,
    required this.year,
    required this.userId,
    required this.stolenWatchId,
    required this.dateStolen,
    required this.images,
  });

  factory StolenWatchModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StolenWatchModel(
      brand: data?['brand'],
      model: data?['model'],
      serialNumber: data?['serialNumber'],
      year: data?['year'],
      userId: data?['userId'],
      stolenWatchId: data?['stolenWatchId'],
      dateStolen: data?['dateStolen'],
      images: List.from(data?['images']),
    );
  }

  factory StolenWatchModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String brand = documentSnapshot.get("brand");
    String model = documentSnapshot.get("model");
    String serialNumber = documentSnapshot.get("serialNumber");
    String year = documentSnapshot.get("year");
    String userId = documentSnapshot.get("userId");
    String stolenWatchId = documentSnapshot.get("stolenWatchId");
    String dateStolen = documentSnapshot.get("dateStolen");
    List<String> images = documentSnapshot.get("images").cast<String>();

    return StolenWatchModel(
        brand: brand,
        model: model,
        serialNumber: serialNumber,
        year: year,
        userId: userId,
        stolenWatchId: stolenWatchId,
        dateStolen: dateStolen,
        images: images);
        
  }

  Map<String, dynamic> toFirestore() {
    return {
      "brand": brand,
      "model": model,
      "serialNumber": serialNumber,
      "year": year,
      "userId": userId,
      "stolenWatchId": stolenWatchId,
      "dateStolen": dateStolen,
      "images": images,
    };
  }
}
