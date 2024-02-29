import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/my_library_model.dart';
import '../../../../database_collection/library.dart';
import '../../../../utils/all_constants.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/shared_preference.dart';
import '../../../../utils/ui_utils.dart';
import '../../../widgets/text.dart';
import '../../library/my_library.dart';

class Library extends StatelessWidget {
  final String userId;
  const Library({Key? key, required this.userId}) : super(key: key);

  Widget library(
      String estimatedValue, String numberOfItems, BuildContext context) {
    String name = SharedPrefs.getString(AppConstants.defaultCurrency) ?? 'EUR';
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyLibrary()),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 10.0, bottom: 10.0, right: 5.0),
                child: customText('Estimated Value',
                    fontSize: 14.0,
                    textAlign: TextAlign.start,
                    textColor: AppColors.textColor,
                    fontWeight: FontWeight.bold),
              ),

              // user library estimated value
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 25.0, bottom: 10.0, right: 10.0),
                child: customText(
                    '${UiUtils.currencySymbol(context, name)} $estimatedValue',
                    fontSize: 28.0,
                    textAlign: TextAlign.start,
                    textColor: AppColors.textColor,
                    fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 15.0, left: 10.0),
                    child: customText('Number of items: ',
                        fontSize: 14.0,
                        textColor: AppColors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: customText(numberOfItems,
                        fontSize: 16.0,
                        textColor: AppColors.textColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget estimatedLibraryValue() {
    return StreamBuilder(
      stream: LibraryDatabaseService(userId: userId).allLibraryData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<MyLibraryModel> libraryItems = List.empty(growable: true);

          for (DocumentSnapshot document in snapshot.data.docs) {
            libraryItems.add(MyLibraryModel.fromDocument(document));
          }

          int sum = 0;

          for (int i = 0; i < libraryItems.length; i++) {
            //price.add(libraryItems[i].price);
            sum += int.parse(
                libraryItems[i].price.replaceAll(RegExp('[^0-9]'), ''));
          }
          NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
          return library(
              myFormat.format(sum), "${libraryItems.length}", context);
        } else {
          return library("0", "0", context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return estimatedLibraryValue();
  }
}
