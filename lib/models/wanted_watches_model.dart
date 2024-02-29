import 'package:cloud_firestore/cloud_firestore.dart';

class WantedWatchModel {
  String brand;
  String model;
  String year;
  String userId;
  String id;
  String boxAndPapers;
  List<String> images;
  String serviceRecords;
  String newOrOld;
  String price;

  WantedWatchModel({
    required this.brand,
    required this.model,
    required this.year,
    required this.userId,
    required this.id,
    required this.images,
    required this.boxAndPapers,
    required this.serviceRecords,
    required this.newOrOld,
    required this.price,
  });

  factory WantedWatchModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return WantedWatchModel(
      brand: data?['brand'],
      model: data?['model'],
      year: data?['year'],
      userId: data?['userId'],
      id: data?['id'],
      images: List.from(data?['images']),
      boxAndPapers: data?['boxAndPapers'],
      serviceRecords: data?['serviceRecords'],
      newOrOld: data?['newOrOld'],
      price: data?['price'],
    );
  }

  factory WantedWatchModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String brand = documentSnapshot.get("brand");
    String model = documentSnapshot.get("model");
    String year = documentSnapshot.get("year");
    String userId = documentSnapshot.get("userId");
    String id = documentSnapshot.get("id");
    List<String> images = documentSnapshot.get("images").cast<String>();
    String boxAndPapers =  documentSnapshot.get("boxAndPapers");
    String serviceRecords = documentSnapshot.get("serviceRecords");
    String newOrOld =  documentSnapshot.get("newOrOld");
    String price = documentSnapshot.get("price");

    return WantedWatchModel(

        brand: brand,
        model: model,
        year: year,
        userId: userId,
        id: id,
        images: images,
        boxAndPapers: boxAndPapers,
        serviceRecords: serviceRecords,
        newOrOld: newOrOld,
        price: price,);
       
  }

  Map<String, dynamic> toFirestore() {
    return {
      "brand": brand,
      "model": model,
      "year": year,
      "userId": userId,
      "id": id,
      "images": images,
      "boxAndPapers": boxAndPapers,
      "serviceRecords": serviceRecords,
      "newOrOld": newOrOld,
      "price": price,
    };
  }
}
