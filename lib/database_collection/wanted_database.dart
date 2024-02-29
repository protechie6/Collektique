import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/wanted_watches_model.dart';

class WantedWatchDatabase {
  //collection Reference
  final CollectionReference wantedCollection =
      FirebaseFirestore.instance.collection("WantedWatches");

  Stream<QuerySnapshot> get wantedWatchData {
    return wantedCollection.snapshots();
  }

  Stream<QuerySnapshot> queryWantedWatchDatabase(String field, String value) {
    return wantedCollection.where(field, isEqualTo: value).snapshots();
  }

  Future insertWantedwatchData(
      String brand,
      String model,
      String year,
      List<String> images,
      String userId,
      String serviceRecords,
      String newOrOld,
      String price,
      String boxAndPapers) async {
    String docId = wantedCollection.doc().id;

    WantedWatchModel wantedWatch = WantedWatchModel(
        brand: brand,
        model: model,
        year: year,
        userId: userId,
        id: docId,
        images: images,
        boxAndPapers: boxAndPapers,
        serviceRecords: serviceRecords,
        newOrOld: newOrOld,
        price: price);

    final docRef = wantedCollection
        .withConverter(
          fromFirestore: WantedWatchModel.fromFirestore,
          toFirestore: (WantedWatchModel data, options) => data.toFirestore(),
        )
        .doc(docId);

    return await docRef.set(wantedWatch);
  }
}
