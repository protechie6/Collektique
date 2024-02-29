import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';
import 'package:watch_vault/ui/widgets/carousel.dart';
import 'package:watch_vault/models/stolen_watches_model.dart';

import '../message/conversation.dart';

class StolenWatchesDetails extends StatelessWidget {

  const StolenWatchesDetails({Key? key, required this.itemDetails}) : super(key: key);

  final StolenWatchModel itemDetails;

  @override
  Widget build(BuildContext context){

    final user = Provider.of<FirebaseUser?>(context);

    Widget stolenText = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "stolen",
        style: TextStyle(
            color: Colors.red,
            fontFamily: 'Poppins',
            fontSize: 18,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.bold,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20,
      ),
      child: const Text(
        "Watch details:",
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
        "Brand: ${itemDetails.brand}",
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
        "Model: ${itemDetails.model}",
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
        "Serial Number: ${itemDetails.serialNumber}",
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
      child: Text(
        "Year: ${itemDetails.year}",
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

    Widget dateStolen = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Date Stolen: ${itemDetails.dateStolen}",
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

    Widget location = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Location: Liverpool",
        style: TextStyle(
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

    Widget contactSeller = Container(
      width: (double.infinity),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "Contact Seller",
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
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Conversation(listItem: itemDetails.userId,)),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${itemDetails.brand} ${itemDetails.model}",
            style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:stolenText,
            ),
            Carousel(images: itemDetails.images),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            FutureBuilder<DocumentSnapshot>(
              future:Users(userId: user!.uid).userData,
              builder:builder),
            dateStolen,
            location,
            Visibility(
              visible: itemDetails.userId != user.uid ? true : false,
              child: contactSeller),
          ],
        ),
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if(snapshot.connectionState == ConnectionState.done){
      UserData userData = UserData.fromDocument(snapshot.data!);
      return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "User: ${userData.username}",
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
    }else{
      return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "User: user",
        style: TextStyle(
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
    }
  }
}
