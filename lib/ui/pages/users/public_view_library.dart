import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:watch_vault/models/my_library_model.dart';

import '../../../database_collection/library.dart';
import '../../../ui/widgets/dialog.dart';
import '../library/widget/my_library_item.dart';

class WatchVaultUserLibrary extends StatefulWidget {
  final String? userId;
  const WatchVaultUserLibrary({Key? key,this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WatchVaultUserLibraryState();
}

class WatchVaultUserLibraryState extends State<WatchVaultUserLibrary> {
  int page = 1;

  late ScrollController _scrollController;

  bool isTop = true;

  Stream? stream;

  @override
  void initState() {
    
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        isTop = false;
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        isTop = true;
      }
    });

    stream = LibraryDatabaseService(userId:'').getPublicViewWatches();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBox = Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
            hintText: "Search watch by brand name",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 32, 72, 72),
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: ImageIcon(
              AssetImage("assets/images/search.png"),
              color: Color.fromARGB(255, 32, 72, 72),
            )),
        onChanged: (value) {},
      ),
    );

    Widget builder(BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<MyLibraryModel> libraryItems = List.empty(growable: true);

        for (DocumentSnapshot document in snapshot.data.docs) {
          libraryItems.add(MyLibraryModel.fromDocument(document));
        }
        return libraryItems.isNotEmpty? GridView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          controller: _scrollController,
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
               isSelected: (bool value) { },
            );
          },
        ): const Center(
          child: Text(
              "No library item",
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
          child: LoadingDialog(),
        );
      }
    }

    Widget gridview = NotificationListener<UserScrollNotification>(
      onNotification: ((notification) {
        final ScrollDirection direction = notification.direction;
        setState(() {
          if (direction == ScrollDirection.reverse) {
            //when we are scrolling towards the end of the list
            setState(() {
              if (isTop) {
                setState(
                  () => page++,
                );
              }
            });
          } else if (direction == ScrollDirection.forward) {
            //when we are scrolling towards the beginning of the list

            setState(
              () {
                if (page != 1) {
                  page--;
                }
              },
            );
          }
        });
        return true;
      }),
      child: StreamBuilder(stream: stream, builder: builder),
    );

    Widget row2 = Center(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$page",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ), // <-- Text
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {
            final screenHeight = MediaQuery.of(context).size.height;
            _scrollController.animateTo(screenHeight,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn); //_scrollController.offset - itemSize,
            if (isTop) {
              setState(
                () => page++,
              );
            }
          },
          icon: const Icon(
            // <-- Icon
            Icons.skip_next,
            size: 24.0,
            color: Colors.white,
          ),
        )
      ],
    ));

    return Scaffold(
      appBar: widget.userId !=null?AppBar(
        title: const Text("User library",
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
      ):null,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            searchBox,
            Expanded(
              child: gridview,
            ),
            row2,
          ],
        ),
      ),
    );
  }
}
