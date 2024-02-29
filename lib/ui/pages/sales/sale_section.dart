import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:watch_vault/ui/pages/sales/upload_sales.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/database_collection/sales_database.dart';

import '../library/my_library.dart';
import 'sale_item.dart';

class SaleSection extends StatefulWidget {
  
  const SaleSection({Key? key}) : super(key: key);

  @override
  State<SaleSection> createState() => SaleSectionState();
}

class SaleSectionState extends State<SaleSection> {

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
    stream = SalesDatabase().salesWatchData;
    super.initState();
  }

  void _showBottomButton() {

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){

          return Container(
             height: (MediaQuery.of(context).size.height)*0.25,
            decoration: const BoxDecoration(
              color:  AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                  ),
                  child: TextButton.icon(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLibrary(fromSales: true)),
                      );
                    },
                    icon: const Icon(
                      Icons.collections,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "My Library",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadSales()),
                      );
                    },
                    icon: const Icon(
                      Icons.upload,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "New Upload",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {

    Widget row1 = Container(
      margin: const EdgeInsets.only(
        top: 0,
        bottom: 20,
      ),
      child: Row(children: <Widget>[
        const Text(
          "Sale",
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
            stream = null;
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
          bottom: 20,
        ),
        child: TextFormField(
          style: const TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 32, 72, 72),
              fontFamily: 'Poppins'),
          decoration: const InputDecoration(
              hintText: "search by brand",
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
              stream = SalesDatabase().querySalesWatchDatabase("brand", value.toString());
            });
          },
        ),
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
        child: StreamBuilder(
            stream: isSearching?stream:SalesDatabase().salesWatchData, builder: builder));

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
        child: const Text(
          "Upload",
          style: TextStyle(
              color: Color.fromRGBO(32, 72, 72, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.bold,
              height: 1 /*PERCENT not supported*/
              ),
        ),
        onPressed: () {
          _showBottomButton();
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
    if (snapshot.hasData) {
      return GridView.builder(
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
          return SaleItem(
            data: snapshot.data?.docs[index],
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          "No sales",
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
}
