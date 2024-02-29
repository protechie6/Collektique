import 'package:cloud_firestore/cloud_firestore.dart';

class SerialDetailsCollection{

//collection Reference
  final CollectionReference serialCollection =
      FirebaseFirestore.instance.collection("serialCheck");

//query by serial number
  Stream<QuerySnapshot> checkSerialNumber(String value) {
    return serialCollection.orderBy('serialNumber')
      .startAt([value])
      .endAt(['$value\uf8ff']).snapshots();
  }

//query by year
  Stream<QuerySnapshot> queryByYear(String value) {
    return serialCollection.orderBy('year')
      .startAt([value])
      .endAt(['$value\uf8ff']).snapshots();
  }

//query by brand
  Stream<QuerySnapshot> serialNumbersOfBrand(String value){
    return serialCollection.where("brand", isEqualTo: value)
    .snapshots();
  }
}
