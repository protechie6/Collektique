import 'package:cloud_firestore/cloud_firestore.dart';

class SerialCheckModel {

  final String year;
  final String serialNumber;

  SerialCheckModel({
    required this.year,
    required this.serialNumber,
  });

  factory SerialCheckModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SerialCheckModel(
      year: data?['year'],
      serialNumber: data?['serialNumber'],
    );
  }

  factory SerialCheckModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String year = documentSnapshot.get("year");
    String serialNumber = documentSnapshot.get("serialNumber");
     return SerialCheckModel(year: year, serialNumber: serialNumber,);
  }

  Map<String, dynamic> toFirestore() {
    
    return {
      "year": year,
       "serialNumber": serialNumber,
    };
  }
}