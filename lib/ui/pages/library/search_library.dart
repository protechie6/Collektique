import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../models/my_library_model.dart';
import '../../../database_collection/library.dart';
import 'widget/my_library_item.dart';

class SearchLibrary extends StatefulWidget {
  const SearchLibrary({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<SearchLibrary> createState() => SearchLibraryState();
}

class SearchLibraryState extends State<SearchLibrary> {
  Stream? stream;

  @override
  Widget build(BuildContext context) {
    
    Widget searchBox = Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0, color: AppColors.textColor, fontFamily: 'Poppins'),
        decoration: const InputDecoration(
            hintText: "Search library",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: ImageIcon(
              AssetImage("assets/images/search.png"),
              color: Color.fromARGB(255, 32, 72, 72),
            )),
        onChanged: (value) {
          setState(() {
            stream = LibraryDatabaseService(userId: widget.userId)
                .searchMyLibrary('brand', value.toString());
          });
        },
      ),
    );

    Widget builder(BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<MyLibraryModel> libraryItems = List.empty(growable: true);

        for (DocumentSnapshot document in snapshot.data.docs) {
          libraryItems.add(MyLibraryModel.fromDocument(document));
        }

        return GridView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: 220),
          itemBuilder: (BuildContext context, int index) {
            return MyLibraryItem(
              itemKey: Key(libraryItems[index].itemId.toString()),
              data: libraryItems[index],
              isSelected: (bool value) {},
            );
          },
        );
      } else {
        return const Center(
          child: Text('No result'),
        );
      }
    }

    Widget searchResult = Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: StreamBuilder(stream: stream, builder: builder),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("My library search",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            )),
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
          children: [
            searchBox,
            searchResult,
          ],
        ));
  }
}
