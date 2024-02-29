import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/database_collection/stolen_database.dart';

import '../../../models/stolen_watches_model.dart';
import '../../../ui/widgets/dialog.dart';
import 'upload_stolen_watch.dart';
import 'stolen_watch_details.dart';
import 'tabs/stolen_items_listview.dart';

class UserStolenCollection extends StatefulWidget {
  const UserStolenCollection({Key? key}) : super(key: key);

  @override
  State<UserStolenCollection> createState() => UserStolenCollectionState();
}

class UserStolenCollectionState extends State<UserStolenCollection> {

  int page = 1;
  late ScrollController _scrollController;

  bool isTop = true;
  
  bool isSearching = false;

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

stream = StolenWatchDatabase().stolenWatchData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget row1 = Container(
      margin: const EdgeInsets.only(
        top: 0,
        bottom: 10,
      ),
      child: Row(children: <Widget>[
        const Text(
          "Stolen",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            setState(()=> isSearching = !isSearching);
          },
          child: const ImageIcon(
            AssetImage("assets/images/search.png"),
            color: Colors.white,
          ),
        ),
      ]),
    );

    Widget searchBox = Visibility(
      visible: isSearching,
      child: Container(
        margin: const EdgeInsets.only(
          top: 0,
          bottom: 15,
        ),
        child: TextFormField(
          style: const TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 32, 72, 72),
              fontFamily: 'Poppins'),
          decoration: const InputDecoration(
              hintText: "search by serial number",
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
          onChanged: (value) {
            setState(() {
              stream = StolenWatchDatabase().queryStolenWatchDatabase("brand", value.toString());
            });
          },
        ),
      ),
    );

    Widget listViewButton = Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      width: (screenWidth / 2.4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "ListView",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StolenItemListView()),
          );
        },
      ),
    );

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

              setState(() {
                if (page != 1) {
                  page--;
                }
              });
            }
          });
          return true;
        }),
        child: StreamBuilder(
          stream:stream,
          builder: builder,
        ),
        );

    Widget button = Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: const Text("Upload",
            style: TextStyle(
                color: Color.fromRGBO(32, 72, 72, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadStolenWatch()),
          );
        },
      ),
    );

    Widget row2 = Row(
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
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
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
    );

    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            row1,
            searchBox,
            Row(
              children: [
              
                listViewButton,
                const Spacer(),
              ],
            ),
            Expanded(
              child: gridview,
            ),
            button,
            row2,
          ],
        ),
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if(snapshot.hasData){
      List<StolenWatchModel> stolenItems = List.empty(growable: true);

        for (DocumentSnapshot document in snapshot.data.docs) {
          stolenItems.add(StolenWatchModel.fromDocument(document));
        }
      return GridView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: stolenItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: 220),
          itemBuilder: (BuildContext context, int index) {
            return StolenWatchItem(stolenWatch: stolenItems[index],);
          },
        );
    }else{
      return const Center(
        child: LoadingDialog(),
      );
    }
  }
}
// GridClass 
class StolenWatchItem extends StatelessWidget {
  const StolenWatchItem({
    Key? key,
    required this.stolenWatch,
  }) : super(key: key);

  final StolenWatchModel stolenWatch;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StolenWatchesDetails(itemDetails: stolenWatch)));
      },
      child: Column(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: stolenWatch.images[0],
            imageBuilder: (context, imageProvider) => Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${stolenWatch.brand} ${stolenWatch.model}",
              style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5 /*PERCENT not supported*/
                  ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

