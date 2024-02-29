import 'package:cloud_firestore/cloud_firestore.dart';

class SalesWatchModel{

  String brand;
  String model;
  String serialNumber;
  String year;
  String insured;
  List<String> serviceRecords;
  String ownedFor;
  String price;
  String userId;
  String id;
  List<String> boxAndPapersList;
  List<String> images;
  List<String> likes;

  SalesWatchModel({
    required this.brand,
    required this.model,
    required this.serialNumber,
    required this.year,
    required this.insured,
    required this.serviceRecords,
    required this.ownedFor,
    required this.price,
    required this.userId,
    required this.id,
    required this.boxAndPapersList,
    required this.images,
    required this.likes,
  });

  factory SalesWatchModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SalesWatchModel(
      brand: data?['brand'],
      model: data?['model'],
      serialNumber: data?['serialNumber'],
      year: data?['year'],
      insured: data?['insured'],
      serviceRecords: List.from(data?['serviceRecords']),
      ownedFor: data?['ownedFor'],
      price: data?['price'],
      userId: data?['userId'],
      id: data?['id'],
      images: List.from(data?['images']),
      boxAndPapersList: List.from(data?['boxAndPapersList']),
      likes: List.from(data?['likes']),
    );
  }

  factory SalesWatchModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String brand = documentSnapshot.get("brand");
    String model = documentSnapshot.get("model");
    String serialNumber = documentSnapshot.get("serialNumber");
    String year = documentSnapshot.get("year");
    String insured = documentSnapshot.get("insured");
    List<String> serviceRecords = documentSnapshot.get("serviceRecords").cast<String>();
    String ownedFor =  documentSnapshot.get("ownedFor");
    String price = documentSnapshot.get("price");
    String userId = documentSnapshot.get("userId");
    String id = documentSnapshot.get("id");
    List<String> boxAndPapersList= documentSnapshot.get("boxAndPapersList").cast<String>();
    List<String> images = documentSnapshot.get("images").cast<String>();
    List<String> likes = documentSnapshot.get("likes").cast<String>();

    return SalesWatchModel(
      brand: brand,
       model: model,
        serialNumber: serialNumber, 
        year: year,
          insured: insured,
           serviceRecords: serviceRecords,
            ownedFor: ownedFor,
             price: price, 
             userId: userId, 
             id: id, 
             boxAndPapersList: boxAndPapersList,
              images: images,
              likes:likes );
       
  }

  Map<String, dynamic> toFirestore() {
    return {
      "brand": brand,
      "model": model,
      "serialNumber": serialNumber,
      "year": year,
      "insured": insured,
      "serviceRecords": serviceRecords,
      "ownedFor": ownedFor,
      "price":price,
      "userId": userId,
      "id": id,
      "images": images,
      "boxAndPapersList": boxAndPapersList,
      "likes": likes,
    };
  }
}