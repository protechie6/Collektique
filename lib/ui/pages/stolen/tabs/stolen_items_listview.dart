import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/stolen_watches_model.dart';
import 'package:watch_vault/ui/pages/stolen/widget/stolen_watch_data_source.dart';

import '../../../../database_collection/stolen_database.dart';
import '../../../../ui/widgets/dialog.dart';

class StolenItemListView extends StatefulWidget {
  const StolenItemListView({Key? key}) : super(key: key);

  @override
  State<StolenItemListView> createState() => StolenItemListViewState();
}

class StolenItemListViewState extends State<StolenItemListView> {

  String dropdownvalue = "Watch brand";

  // List of items in our dropdown menu
  List<String> items = [
    "Watch brand",
    "A.Lange & Söhne",
    "Alpina",
    "Armani",
    "Arnold & Son",
    "Audemars Piguet",
    "Bamford",
    "Baume & Mercier",
    "Bell & Ross",
    "Blancpain",
    "Breitling",
    "Bremont",
    "Bulgari",
    "Bulova",
    "Bovet Fleurier",
    "Cartier",
    "Chopard",
    "Digital watches",
    "F.P.Journe",
    "Girard-Perregaux",
    "Gucci",
    "Hamilton",
    "Hublot",
    "IWC Schaffhausen",
    "Jaeger-LeCoultre",
    "Jaquet Droz",
    "Junghans",
    "Laurent Ferrier",
    "LIV Watches",
    "Longines",
    "Louis Vuitton",
    "Maurice de Mauriac",
    "Maurice Lacroix",
    "Montblanc",
    "NOMOS Glashütte",
    "Nordgreen",
    "Omega",
    "Oris",
    "Panerai",
    "Parmigiani Fleurier",
    "Patek Philippe",
    "Piaget",
    "Rado",
    "Roger Dubuis",
    "Rolex",
    "Seiko",
    "TAG Heuer",
    "Tiffany & Co.",
    "Tissot",
    "Tudor",
    "Ulysse Nardin",
    "Vacheron Constantin",
    "Van Cleef & Arpels",
    "Vincero",
    "Weiss",
    "Zenith",
  ];

  Stream? stream;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget dropDown = DropdownButton(
      // Initial Value
      value: dropdownvalue,
      underline: Container(),
      dropdownColor: AppColors.backgroundColor,
      style: const TextStyle(color: Colors.white),
      // Down Arrow Icon
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 18.0,
        color: Colors.white,
      ),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1)),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
          if(dropdownvalue!="Watch brand"){
            stream = StolenWatchDatabase()
                  .queryStolenWatchDatabase("brand",newValue);
              isSearching = true;
          }else{
              isSearching = false;
          }
        });
      },
    );

    Widget stolenListBuilder() {
      return StreamBuilder(
          stream: isSearching?stream:StolenWatchDatabase().stolenWatchData,
          builder: builder,
        );
    }
    
    return Padding(
          padding: const EdgeInsets.all(10),
          
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: dropDown),
                  stolenListBuilder(),
                ],
              ),
          ),
          );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<StolenWatchModel> result = List.empty(growable: true);

      for (DocumentSnapshot document in snapshot.data.docs) {
        result.add(StolenWatchModel.fromDocument(document));
      }

      StolenWatchesDataSource dataSource = StolenWatchesDataSource(
        docs: result,
      );

      return Theme(
        data: Theme.of(context).copyWith(
            cardColor: AppColors.backgroundColor, dividerColor: Colors.white),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Year',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
            DataColumn(
              label: Text(
                'Model',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
            DataColumn(
              label: Text(
                'Serial',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
            DataColumn(
              label: Text(
                'Stolen',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
            DataColumn(
              label: Text(
                'User',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
          ],
          source: dataSource,
          arrowHeadColor: Colors.white,
          horizontalMargin: 10,
          rowsPerPage: 8,
          showCheckboxColumn: false,
        ),
      );
    } else {
      return const Center(
        child: LoadingDialog(),
      );
    }
  }
}
