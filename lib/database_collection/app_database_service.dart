import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_vault/models/app_data_model.dart';

class VaultDatabaseService{

   //collection Reference
  final CollectionReference app =
      FirebaseFirestore.instance.collection("Vault");

 Future<AppDataModel?> _appModel() async {
    final ref = app.doc("app").withConverter(
          fromFirestore: AppDataModel.fromFirestore,
          toFirestore: (AppDataModel data, _) => data.toFirestore(),
        );
    final docSnap = await ref.get();
    final data = docSnap.data(); 
    return data;
  }

// get a user data
  Future<AppDataModel?> get appData {
    return _appModel();
  }

}