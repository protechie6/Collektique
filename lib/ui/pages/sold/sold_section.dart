import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/sold_item_model.dart';
import 'package:watch_vault/database_collection/library.dart';

import 'sold_item.dart';

class SoldSection extends StatefulWidget {
  const SoldSection({Key? key}) : super(key: key);

  @override
  State<SoldSection> createState() => SoldSectionState();
}

class SoldSectionState extends State<SoldSection> {
  Stream? stream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = Provider.of<UserData>(context);

    LibraryDatabaseService libraryDatabaseService =
        LibraryDatabaseService(userId: user.id);

    stream = libraryDatabaseService.soldItems;
  }

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<SoldItemModel> soldItems = List.empty(growable: true);

        for (DocumentSnapshot document in snapshot.data.docs) {
          soldItems.add(SoldItemModel.fromDocument(document));
        }
        return soldItems.isNotEmpty? ListView.builder(
          itemCount: soldItems.length,
          itemBuilder: (BuildContext context, int index) {
            return SoldItem(
              soldItem: soldItems[index],
            );
          },
        ): const Center(
          child: Text(
            "No sold item",
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
      } else {
        return const Center(
          child: Text(
            "No sold item",
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
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Sold Items",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            )),
        centerTitle: true,
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
        elevation: 0,
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
