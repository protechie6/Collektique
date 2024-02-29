import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/saved_item_model.dart';
import 'package:watch_vault/database_collection/library.dart';

import '../../../widgets/dialog.dart';
import 'saved_item_list_item.dart';

class SavedItem extends StatefulWidget{
  
  const SavedItem({Key? key}) : super(key: key);

  @override
  State<SavedItem> createState()=>SavedItemState();

}
class SavedItemState extends State<SavedItem>{

  Stream? stream;

   @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();

    final user = Provider.of<UserData>(context);

    LibraryDatabaseService libraryDatabaseService = LibraryDatabaseService(userId: user.id);

    stream = libraryDatabaseService.savedItems;
  }

  @override
  Widget build(BuildContext context) {

    Widget builder(BuildContext context, AsyncSnapshot snapshot) {

if(snapshot.hasData){
   List<SavedItemModel> savedItems =
                      List.empty(growable: true);

                  for (DocumentSnapshot document in snapshot.data.docs) {
                    savedItems.add(SavedItemModel.fromDocument(document));
                  }
         return savedItems.isNotEmpty? ListView.builder(
                itemCount: savedItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return SavedItemListView(
                    savedItem: savedItems[index],
                  );
                },
              ): const Center(
          child: Text(
            "No Item",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 12,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                ),
          ),
        );
      }else{
        return const Center(
          child: LoadingDialog(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Saved item",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: "Poppins",
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: stream,
                builder: builder,
              ),
            ),
          ],
        ),
    );
  }
}