import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/my_library_model.dart';
import 'package:watch_vault/models/saved_item_model.dart';
import 'package:watch_vault/models/sold_item_model.dart';

import '../models/sales_model.dart';

class LibraryDatabaseService {
//userId
  final String userId;

  LibraryDatabaseService({
    required this.userId,
  });

  //collection Reference
  final CollectionReference libraryCollection =
      FirebaseFirestore.instance.collection("userLibraries");

// insert
  Future insertLibraryData(
      String brand,
      String model,
      String year,
      String serialNumber,
      List<String> images,
      List<String> boxAndPapers,
      String insured,
      List<String> serviceRecords,
      String ownedFor,
      String forSale,
       String type,
        String size,
        String colour,
        String bodyWorkOrAccident,
       String  numberPlate,
        String condition,
      String price) async {

    String docId = libraryCollection.doc().id;

    MyLibraryModel myLibrary = MyLibraryModel(
      userId: userId,
      itemId: docId,
        brand: brand,
        model: model,
        serialNumber: serialNumber,
        year: year,
        boxAndPapers: boxAndPapers,
        images: images,
        insured: insured,
        serviceRecord: serviceRecords,
        ownedFor: ownedFor,
        forSale: forSale,
        price: price,
        type: type,
        size: size,
        colour: colour,
        bodyWorkOrAccident:bodyWorkOrAccident ,
        numberPlate: numberPlate,
        condition: condition,
        view: "private");

    final docRef = libraryCollection
        .doc(userId)
        .collection("myLibrary")
        .withConverter(
          fromFirestore: MyLibraryModel.fromFirestore,
          toFirestore: (MyLibraryModel data, options) => data.toFirestore(),
        )
        .doc(docId);

    return await docRef.set(myLibrary);
  }

//set public view watches
  Future updateLibraryItemView(String value, String docId, MyLibraryModel myLibraryModel) async {
    final docRef =
        libraryCollection.doc(userId).collection("myLibrary").doc(docId);
    return await docRef.update({"view": value}).then((value){
      MyLibraryModel model = MyLibraryModel(
        userId: myLibraryModel.userId, 
        itemId: myLibraryModel.itemId, 
      brand: myLibraryModel.brand, 
      model: myLibraryModel.model, 
      serialNumber: '', 
      year: myLibraryModel.year, 
      boxAndPapers: myLibraryModel.boxAndPapers, 
      images: myLibraryModel.images, 
      insured: myLibraryModel.insured, 
      serviceRecord: myLibraryModel.serviceRecord, 
      ownedFor: myLibraryModel.ownedFor, 
      forSale: myLibraryModel.forSale, 
      price: myLibraryModel.price, 
      type: myLibraryModel.type, 
      size: myLibraryModel.size,
      colour: myLibraryModel.colour,
      bodyWorkOrAccident: myLibraryModel.bodyWorkOrAccident,
      numberPlate: myLibraryModel.numberPlate, 
      condition: myLibraryModel.condition, 
      view: 'public'
      );
      FirebaseFirestore.instance.collection('publicViewItems')
      .withConverter(
          fromFirestore: MyLibraryModel.fromFirestore,
          toFirestore: (MyLibraryModel data, options) => data.toFirestore(),
        ).doc(docId).set(model);
    });
  }

Future makePrivateView(String value, String docId,) async {
    final docRef =
        libraryCollection.doc(userId).collection("myLibrary").doc(docId);
    return await docRef.update({"view": value}).then((value){
      FirebaseFirestore.instance.collection('publicViewItems')
      .doc(docId).delete();
    });
  }

  //share lbrary item with member
  Future shareWithMember(MyLibraryModel myLibraryModel, String receiverId, String username)async{

    SavedItemModel myLibrary = SavedItemModel(
      id: myLibraryModel.itemId,
        brand: myLibraryModel.brand,
        model: myLibraryModel.model,
        year: myLibraryModel.year,
        images: myLibraryModel.images,
        boxAndPapers: myLibraryModel.boxAndPapers,
        serviceRecord: myLibraryModel.serviceRecord,
        insured: myLibraryModel.insured,
        ownedFor: myLibraryModel.ownedFor,
        forSale: myLibraryModel.forSale,
        price: myLibraryModel.price,
        type: myLibraryModel.type,
        size:myLibraryModel.size,
        colour: myLibraryModel.colour,
        bodyWorkOrAccident: myLibraryModel.bodyWorkOrAccident,
        numberPlate: myLibraryModel.numberPlate,
        condition: myLibraryModel.condition,
        view: "private", 
        sharedBy: username, 
        date: DateTime.now().millisecondsSinceEpoch.toString(),);

    final docRef = libraryCollection
        .doc(receiverId)
        .collection("Saved")
        .withConverter(
          fromFirestore: SavedItemModel.fromFirestore,
          toFirestore: (SavedItemModel data, options) => data.toFirestore(),
        )
        .doc(myLibraryModel.itemId);

    return await docRef.set(myLibrary);
  }

// save from sales
  Future saveFromSales(SalesWatchModel salesWatchModel)async{

    SavedItemModel myLibrary = SavedItemModel(
      id: salesWatchModel.id,
        brand: salesWatchModel.brand,
        model: salesWatchModel.model,
        year: salesWatchModel.year,
        images: salesWatchModel.images,
        boxAndPapers: salesWatchModel.boxAndPapersList,
        serviceRecord: salesWatchModel.serviceRecords,
        insured: salesWatchModel.insured,
        ownedFor: salesWatchModel.ownedFor,
        forSale: 'Yes',
        price: salesWatchModel.price,
        type: '',
        size:'',
        colour: '',
        bodyWorkOrAccident: '',
        numberPlate: '',
        condition: '',
        view: "private", 
        sharedBy: '', 
        date: DateTime.now().millisecondsSinceEpoch.toString(),);

    final docRef = libraryCollection
        .doc(userId)
        .collection("Saved")
        .withConverter(
          fromFirestore: SavedItemModel.fromFirestore,
          toFirestore: (SavedItemModel data, options) => data.toFirestore(),
        )
        .doc(salesWatchModel.id);

    return await docRef.set(myLibrary);
  }

  Future <void> removeSavedItem(String itemId)async{
    libraryCollection.doc(userId).collection('Saved').doc(itemId).delete();
  }

//transfer item to member
  Future transferToMember(MyLibraryModel myLibraryModel, String receiverId,)async{

    final batch = FirebaseFirestore.instance.batch();

    MyLibraryModel myLibrary = MyLibraryModel(
      userId:receiverId,
      itemId: myLibraryModel.itemId,
        brand: myLibraryModel.brand,
        model: myLibraryModel.model,
        serialNumber: myLibraryModel.serialNumber,
        year: myLibraryModel.year,
        images: myLibraryModel.images,
        boxAndPapers: myLibraryModel.boxAndPapers,
        serviceRecord: myLibraryModel.serviceRecord,
        insured: myLibraryModel.insured,
        ownedFor: myLibraryModel.ownedFor,
        forSale: myLibraryModel.forSale,
        price: myLibraryModel.price,
        type:myLibraryModel.type,
        size:myLibraryModel.size,
        colour:myLibraryModel.colour ,
        bodyWorkOrAccident: myLibraryModel.bodyWorkOrAccident,
        numberPlate: myLibraryModel.numberPlate,
        condition:myLibraryModel.condition ,
        view: "private");

// the receiving member's document reference
    final docRef = libraryCollection
        .doc(receiverId)
        .collection("myLibrary")
        .withConverter(
          fromFirestore: MyLibraryModel.fromFirestore,
          toFirestore: (MyLibraryModel data, options) => data.toFirestore(),
        )
        .doc(myLibraryModel.itemId);
        batch.set(docRef, myLibrary);

// the sending member's document reference

SoldItemModel soldItem = SoldItemModel(
      id: myLibraryModel.itemId,
        brand: myLibraryModel.brand,
        model: myLibraryModel.model,
        serialNumber: myLibraryModel.serialNumber,
        year: myLibraryModel.year,
        images: myLibraryModel.images,
        boxAndPapers: myLibraryModel.boxAndPapers,
        serviceRecord: myLibraryModel.serviceRecord,
        insured: myLibraryModel.insured,
        ownedFor: myLibraryModel.ownedFor,
        forSale: myLibraryModel.forSale,
        price: myLibraryModel.price,
        type:myLibraryModel.type,
        size:myLibraryModel.size,
        colour:myLibraryModel.colour ,
        bodyWorkOrAccident: myLibraryModel.bodyWorkOrAccident,
        numberPlate: myLibraryModel.numberPlate,
        condition:myLibraryModel.condition ,
        view: "private", 
        soldTo: receiverId, 
        date: DateTime.now().millisecondsSinceEpoch.toString(),);
        
        final docRef2 = libraryCollection
        .doc(userId)
        .collection("Sold")
        .withConverter(
          fromFirestore: SoldItemModel.fromFirestore,
          toFirestore: (SoldItemModel data, options) => data.toFirestore(),
        )
        .doc(myLibraryModel.itemId);
        batch.set(docRef2, soldItem);

        final docRef3 = libraryCollection
        .doc(userId)
        .collection("myLibrary")
        .withConverter(
          fromFirestore: MyLibraryModel.fromFirestore,
          toFirestore: (MyLibraryModel data, options) => data.toFirestore(),
        )
        .doc(myLibraryModel.itemId);
        batch.delete(docRef3);
        

    return await batch.commit();
  }

//get Stream
  Stream<QuerySnapshot> libraryData(String value){
    return libraryCollection.doc(userId).collection("myLibrary").where("type", isEqualTo: value).snapshots();
  }

  //get Stream
  Stream<QuerySnapshot> allLibraryData(){
    return libraryCollection.doc(userId).collection("myLibrary").snapshots();
  }

//get savedItem
  Stream<QuerySnapshot> get savedItems {
    return libraryCollection.doc(userId).collection("Saved").snapshots();
  }

  // get sold items
  Stream<QuerySnapshot> get soldItems {
    return libraryCollection.doc(userId).collection("Sold").snapshots();
  }

  //query by view
  Stream<QuerySnapshot> getUserPublicViewWatches(String field) {
    return libraryCollection
        .doc(userId)
        .collection("myLibrary")
        .where(field, isEqualTo: "public")
        .snapshots();
  }

  //get public view watches
  Stream<QuerySnapshot> getPublicViewWatches() {
    return FirebaseFirestore.instance.
    collection("publicViewItems")
        .snapshots();
  }

  //query by view
  Stream<QuerySnapshot> getTopAssets() {
    return libraryCollection
        .doc(userId)
        .collection("myLibrary")
        .orderBy('price', descending: true)
        .limit(2)
        .snapshots();
  }

  // search library
  Stream<QuerySnapshot> searchMyLibrary(String field, String value){
    return libraryCollection.doc(userId).collection("myLibrary").where(field, isEqualTo:value).snapshots();
  }

}
