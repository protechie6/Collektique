
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/serial_check_model.dart';
import 'package:watch_vault/ui/pages/serial%20check/serial_check_data_source.dart';
import '../../../database_collection/serial_details_collection.dart';
import '../../../ui/widgets/dialog.dart';
import '../../widgets/text.dart';

class SerialCheck extends StatefulWidget {
  const SerialCheck({Key? key}) : super(key: key);

  @override
  State<SerialCheck> createState() => SerialCheckState();
}

class SerialCheckState extends State<SerialCheck> {
  Stream? stream;
  String dropdownvalue = "Rolex";
  String filter = "Serial Number";
  late List<SerialCheckModel> docs;

  @override
  void initState() {
    super.initState();
    stream = SerialDetailsCollection().serialNumbersOfBrand(dropdownvalue);
  }

  Widget filters() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (screenWidth),
      margin: const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
      child: Row(
        children: [
          SizedBox(
            width: (screenWidth / 2.3),
            child: RadioListTile(
              title: customText("Serial Number",
                  fontSize: 12.0, textAlign: TextAlign.start),
              value: "Serial Number",
              groupValue: filter,
              activeColor: Colors.white,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  filter="Serial Number";
                });
              },
            ),
          ),
          SizedBox(
            width: (screenWidth / 2.3),
            child: RadioListTile(
              title: customText("Year",
                  fontSize: 12.0, textAlign: TextAlign.start),
              value: "year",
              groupValue: filter,
              activeColor: Colors.white,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  filter="year";
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
      child: TextFormField(
        style: textStyle(fontSize: 14.0, color: AppColors.textColor),
        decoration: InputDecoration(
            hintText: "Search by $filter",
            hintStyle: textStyle(fontSize: 14.0, color: AppColors.textColor),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const ImageIcon(
              AssetImage("assets/images/search.png"),
              color: AppColors.backgroundColor,
            )),
        onChanged: (value) {
          if(filter=="Serial Number"){
            setState(() {
            stream =
                SerialDetailsCollection().checkSerialNumber(value.toString());
          });
          }else{
            setState(() {
            stream =
                SerialDetailsCollection().queryByYear(value.toString());
          });
          }
        },
      ),
    );
  }

  Widget searchResult() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {

            List<SerialCheckModel> result = List.empty(growable: true);

            for (DocumentSnapshot document in snapshot.data.docs) {
              result.add(SerialCheckModel.fromDocument(document));
              result.sort((a, b) => b.year.compareTo(a.year));
            }

            SerialCheckDataSource dataSource = SerialCheckDataSource(
              docs: result,
            );

            return result.isNotEmpty
                ? Theme(
                    data: Theme.of(context).copyWith(
                        cardColor: AppColors.backgroundColor,
                        dividerColor: Colors.white),
                    child: PaginatedDataTable(
                      columns: [
                        DataColumn(
                          label: customText(
                            'Year',
                            fontSize: 14,
                          ),
                        ),
                        DataColumn(
                          label: customText(
                            'serial',
                            fontSize: 14,
                          ),
                        ),
                      ],
                      source: dataSource,
                      columnSpacing: 100,
                      arrowHeadColor: Colors.white,
                      horizontalMargin: 10,
                      rowsPerPage: 8,
                      showCheckboxColumn: false,
                      primary:true,
                    ),
                  )
                : Center(
                    child: customText(
                      "Loading...",
                      fontSize: 14.0,
                    ),
                  );
          } else {
            return const Center(child: LoadingDialog());
          }
        },
      ),
    );
  }

  Widget dropDown() {
    return Container(
      margin: const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
      child: DropdownButton(
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
        items: AppConstants.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: customText(
              items,
              fontSize: 15,
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            stream =
                SerialDetailsCollection().serialNumbersOfBrand(dropdownvalue);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText("Serial check",
            fontSize: 18, fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin:
                    const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: customText('Search filter: ',
                    fontSize: 12.0,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold)),
            filters(),
            searchBox(),
            Container(
                margin:
                    const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: customText('SortBy: ',
                    fontSize: 12.0,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold),),
            dropDown(),
            searchResult(),
          ],
        ),
      ),
    );
  }
}
