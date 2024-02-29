import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/stolen_watches_model.dart';

class StolenWatchDatabase{

   //collection Reference
  final CollectionReference stolenCollection =
      FirebaseFirestore.instance.collection("StolenWatches");

  Stream<QuerySnapshot> get stolenWatchData {
    return stolenCollection
        .snapshots();
  }

  Stream<QuerySnapshot> queryStolenWatchDatabase(String field, String value){
    return stolenCollection.where(field, isEqualTo:value).snapshots();
  } 

   Future insertStolenWatchData(String brand, String model, String serialNumber,
      String year, String dateStolen, List<String> images, userId) async {
    
    String docId = stolenCollection.doc().id;

    StolenWatchModel stolenWatch = StolenWatchModel(
                brand: brand,
                model: model,
                serialNumber: serialNumber,
                year: year,
                userId: userId,
                stolenWatchId: docId,
                dateStolen: dateStolen,
                images: images);

    final docRef = stolenCollection
        .withConverter(
          fromFirestore: StolenWatchModel.fromFirestore,
          toFirestore: (StolenWatchModel data, options) => data.toFirestore(),
        )
        .doc(docId);

    return await docRef.set(stolenWatch);
  }

}