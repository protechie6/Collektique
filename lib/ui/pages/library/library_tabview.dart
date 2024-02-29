import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/ui/pages/library/uploads/upload_bags.dart';
import 'package:watch_vault/ui/pages/library/uploads/upload_shoes.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/my_library_model.dart';
import 'package:watch_vault/database_collection/library.dart';
import 'package:watch_vault/database_collection/sales_database.dart';
import '../../../utils/shared_preference.dart';
import '../../../utils/ui_utils.dart';
import '../../widgets/dialog.dart';
import '../../widgets/text.dart';
import 'widget/my_library_item.dart';
import 'uploads/upload_cars.dart';
import 'uploads/upload_watch.dart';

class LibraryTabView extends StatefulWidget {
  const LibraryTabView(
      {Key? key,
      required this.userId,
      required this.libraryCollection,
      required this.fromSales,
      required this.fromStolen,
      required this.accountType})
      : super(key: key);

  final String userId;
  final String libraryCollection;
  final bool fromSales;
  final bool fromStolen;
  final String accountType;

  @override
  State<StatefulWidget> createState() => LibraryTabViewState();
}

class LibraryTabViewState extends State<LibraryTabView> {
  int salesUpload = 0;

  bool isUploading = false;

  late String name;

  List<MyLibraryModel> selectedList = List.empty(growable: true);

  @override
  void initState() {
    name = SharedPrefs.getString(AppConstants.defaultCurrency) ?? 'EUR';
    super.initState();
  }

  void uploadToSales() {
    for (int i = 0; i < selectedList.length; i++) {
      setState(() => salesUpload = i);

      SalesDatabase().insertSalewatchData(
          selectedList[i].brand,
          selectedList[i].model,
          selectedList[i].serialNumber,
          selectedList[i].year,
          selectedList[i].insured,
          selectedList[i].serviceRecord,
          selectedList[i].ownedFor,
          selectedList[i].price,
          widget.userId,
          selectedList[i].boxAndPapers,
          selectedList[i].images);

      if (i == (selectedList.length - 1)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget itemValue(List<MyLibraryModel> libraryItems) {
      //List<String> price = List.empty(growable:true);

      int sum = 0;

      for (int i = 0; i < libraryItems.length; i++) {
        //price.add(libraryItems[i].price);
        sum +=
            int.parse(libraryItems[i].price.replaceAll(RegExp('[^0-9]'), ''));
      }
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Text(
          "Items value = ${UiUtils.currencySymbol(context, name)} $sum",
          style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      );
    }

    Widget gridview(List<MyLibraryModel> libraryItems) {
      return GridView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: libraryItems.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 220),
        itemBuilder: (BuildContext context, int index) {
          return index < libraryItems.length
              ? MyLibraryItem(
                  itemKey: Key(libraryItems[index].itemId.toString()),
                  data: libraryItems[index],
                  fromSale: widget.fromSales,
                  fromStolen: widget.fromStolen,
                  isSelected: (bool value) {
                    setState(() {
                      if (value) {
                        selectedList.add(libraryItems[index]);
                      } else {
                        selectedList.remove(libraryItems[index]);
                      }
                    });
                  },
                )
              : Visibility(
                  visible:
                      (widget.fromSales || widget.fromStolen) ? false : true,
                  child: GestureDetector(
                    onTap: () {
                      verifyUserAccountStatus(libraryItems.length);
                    },
                    child: Container(
                      height: 100.0,
                      /*decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),*/
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 150.0,
                            height: 150.0,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 32.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: customText(
                              "Add item",
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      );
    }

    /* Widget button = Container(
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: const Text("Done",
            style: TextStyle(
                color: Color.fromRGBO(32, 72, 72, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () {},
      ),
    );*/

    Widget uploadingToSales = Center(
      child: Column(children: [
        const LoadingDialog(),
        Text("$salesUpload Uploading",
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                )),
      ]),
    );

    return isUploading
        ? uploadingToSales
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: LibraryDatabaseService(userId: widget.userId)
                  .libraryData(widget.libraryCollection),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<MyLibraryModel> libraryItems =
                      List.empty(growable: true);

                  for (DocumentSnapshot document in snapshot.data.docs) {
                    libraryItems.add(MyLibraryModel.fromDocument(document));
                  }

                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: itemValue(libraryItems),
                      ),
                      Expanded(child: gridview(libraryItems)),
                      /*Visibility(
                        visible: widget.notFromSale,
                        child: button,
                      ),*/
                    ],
                  );
                } else {
                  return const Center(
                    child: LoadingDialog(),
                  );
                }
              },
            ),
          );
  }

  void verifyUserAccountStatus(int numOfItems) {
    if (widget.accountType == AppConstants.basic && numOfItems == 3) {
      UiUtils.upgradeAccountDialog(context);
    } else if (widget.accountType == AppConstants.pro && numOfItems == 10) {
      UiUtils.upgradeAccountDialog(context);
    } else {
      uploadAnItem();
    }
  }

  void uploadAnItem() {
    switch (widget.libraryCollection) {
      case "Shoes":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UploadShoe(),
          ),
        );
        break;

      case "Bags":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UploadBag(),
          ),
        );
        break;

      case "Cars":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UploadCar(),
          ),
        );
        break;

      default:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UploadWatch(),
          ),
        );
        break;
    }
  }
}
