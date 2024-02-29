import 'package:cloud_firestore/cloud_firestore.dart';

class MyLibraryModel {
  final String userId;
  final String itemId;
  final String brand;
  final String model;
  final String serialNumber;
  final String year;
  final List<String> boxAndPapers;
  final List<String> images;
  final String insured;
  final List<String> serviceRecord;
  final String ownedFor;
  final String forSale;
  final String price;
  final String type;
  final String bodyWorkOrAccident;
  final String colour;
  final String numberPlate;
  final String size;
  final String condition;
  final String view;

  MyLibraryModel({
    required this.userId,
    required this.itemId,
    required this.brand,
    required this.model,
    required this.serialNumber,
    required this.year,
    required this.boxAndPapers,
    required this.images,
    required this.insured,
    required this.serviceRecord,
    required this.ownedFor,
    required this.forSale,
    required this.price,
    required this.type,
    required this.size,
    required this.colour,
    required this.bodyWorkOrAccident,
    required this.numberPlate,
    required this.condition,
    required this.view,
  });

  factory MyLibraryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyLibraryModel(
        userId: data?['userId'],
        itemId: data?['itemId'],
        brand: data?['brand'],
        model: data?['model'],
        serialNumber: data?['serialNumber'],
        year: data?['year'],
        boxAndPapers: List.from(data?['boxAndPapers']),
        images: List.from(data?['images']),
        insured: data?['insured'],
        serviceRecord: List.from(data?['serviceRecord']),
        ownedFor: data?['ownedFor'],
        forSale: data?['forSale'],
        price: data?['price'],
        type: data?['type'],
        size: data?['size'],
        colour: data?['colour'],
        bodyWorkOrAccident: data?['bodyworkOrAccident'],
        numberPlate: data?['numberPlate'],
        condition: data?['condition'],
        view: data?['view']);
  }

  factory MyLibraryModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String userId = documentSnapshot.get("userId");
    String itemId = documentSnapshot.get("itemId");
    String brand = documentSnapshot.get("brand");
    String model = documentSnapshot.get("model");
    String serialNumber = documentSnapshot.get("serialNumber");
    String year = documentSnapshot.get("year");
    List<String> boxAndPapers = documentSnapshot.get("boxAndPapers").cast<String>();
    List<String> images = documentSnapshot.get("images").cast<String>();
    String insured = documentSnapshot.get("insured");
    List<String> serviceRecord = documentSnapshot.get("serviceRecord").cast<String>();
    String ownedFor = documentSnapshot.get("ownedFor");
    String forSale = documentSnapshot.get("forSale");
    String price = documentSnapshot.get("price");
    String type = documentSnapshot.get("type");
    String size = documentSnapshot.get("size");
    String colour = documentSnapshot.get("colour");
    String bodyWorkOrAccident = documentSnapshot.get("bodyworkOrAccident");
    String numberPlate = documentSnapshot.get("numberPlate");
    String condition = documentSnapshot.get("condition");
    String view = documentSnapshot.get("view");

    return MyLibraryModel(
      userId: userId,
      itemId: itemId,
      brand: brand,
      model: model,
      serialNumber: serialNumber,
      year: year,
      boxAndPapers: boxAndPapers,
      images: images,
      insured: insured,
      serviceRecord: serviceRecord,
      ownedFor: ownedFor,
      forSale: forSale,
      price: price,
      type: type,
    size: size,
    colour: colour,
    bodyWorkOrAccident: bodyWorkOrAccident,
    numberPlate: numberPlate,
    condition: condition,
      view: view,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "itemId": itemId,
      "brand": brand,
      "model": model,
      "serialNumber": serialNumber,
      "year": year,
      "boxAndPapers": boxAndPapers,
      "images": images,
      "insured": insured,
      "serviceRecord": serviceRecord,
      "ownedFor": ownedFor,
      "forSale": forSale,
      "price": price,
      "type": type,
      "size": size,
      "colour": colour,
      "bodyworkOrAccident": bodyWorkOrAccident,
      "numberPlate": numberPlate,
      "condition": condition,
      "view": view,
    };
  }
}
