import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/sold_item_model.dart';
import 'package:watch_vault/database_collection/users.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/ui/widgets/carousel.dart';

class SoldItemDetails extends StatelessWidget {
  const SoldItemDetails({Key? key, required this.soldItem}) : super(key: key);

  final SoldItemModel soldItem;

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    
    Widget textSection = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "${soldItem.brand} ${soldItem.model}",
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 20,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
      ),
      child: const Text(
        "Item details:",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 18,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget brand = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Brand: ${soldItem.brand}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget model = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Model: ${soldItem.model}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

  Widget serialNumber = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Serial Number: ${soldItem.serialNumber}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child:  Text(
        "Year: ${soldItem.year}",
        style:const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Box and Papers: ${soldItem.boxAndPapers.length} image(s)",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

     Widget dateOfSale = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child:  Text(
        "Date of Sale: ${DateFormat('dd MMM yyyy, hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(soldItem.date),
                      ),
                    )}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget serviceRecords = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Service Records: ${soldItem.serviceRecord.length} image(s)",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget soldTo = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: FutureBuilder(
        future: Users(
                        userId: soldItem.soldTo,
                      ).userData,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            UserData userData = UserData.fromDocument(snapshot.data!);
            return Text(
                            "Sold to: ${userData.username}",
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
                            overflow: TextOverflow.ellipsis,
                          );
          }else{
            return Container();
          }
        },
      ),
    );

    Widget price = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Sold Price: ${soldItem.price}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );


    Widget contact = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "Contact",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        onPressed: () {
          
        },
      ),
    );

    Widget favorite = Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 20,
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Icon(
                    Icons.favorite_outline_outlined,
                    size: 24.0,
                    color: AppColors.textColor,
                  ),
        onPressed: () {
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sold watch details",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textSection,
            Carousel(images: soldItem.images,),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            dateOfSale,
            serviceRecords,
            soldTo,
            price,

            Row(
              children: [
                SizedBox(
                  width: (screenWidth / 2),
                  child: contact,
                ),
                const Spacer(),
                SizedBox(
                  width: (screenWidth / 2),
                  child: favorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
