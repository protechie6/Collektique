import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/sales_model.dart';

class SalesDatabase {
  //collection Reference
  final CollectionReference salesCollection =
      FirebaseFirestore.instance.collection("SaleWatches");

  Stream<QuerySnapshot> get salesWatchData {
    return salesCollection.snapshots();
  }

// query database
  Stream<QuerySnapshot> querySalesWatchDatabase(String field, String value) {
    return salesCollection.where(field, isEqualTo: value).snapshots();
  }

  Future insertSalewatchData(
    String brand,
    String model,
    String serialNumber,
    String year,
    String insured,
    List<String> serviceRecords,
    String ownedFor,
    String price,
    String userId,
    List<String> boxAndPapersList,
    List<String> images,
  ) async {
    String docId = salesCollection.doc().id;

    SalesWatchModel saleWatch = SalesWatchModel(
        brand: brand,
        model: model,
        serialNumber: serialNumber,
        year: year,
        insured: insured,
        serviceRecords: serviceRecords,
        ownedFor: ownedFor,
        price: price,
        userId: userId,
        id: docId,
        boxAndPapersList: boxAndPapersList,
        images: images,
        likes:[]);

    final docRef = salesCollection
        .withConverter(
          fromFirestore: SalesWatchModel.fromFirestore,
          toFirestore: (SalesWatchModel data, options) => data.toFirestore(),
        )
        .doc(docId);

    return await docRef.set(saleWatch);
  }

// like sales item
  Future likeSalesItem(String docId, String value) async {
    final docRef = salesCollection.doc(docId);
    return await docRef.update({'likes': FieldValue.arrayUnion([value])});
  }

  Future unlikeSaleItem(String docId, String value)async{
    final docRef = salesCollection.doc(docId);
    return await docRef.update({'likes': FieldValue.arrayRemove([value])});
  }
  
}
