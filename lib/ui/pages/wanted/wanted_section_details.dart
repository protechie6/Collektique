import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/wanted_watches_model.dart';
import 'package:watch_vault/ui/widgets/carousel.dart';

import '../../../database_collection/users.dart';
import '../../widgets/simpleton.dart';
import '../../widgets/text.dart';
import '../message/conversation.dart';

class WantedSectionDetails extends StatelessWidget {

  const WantedSectionDetails({Key? key, required this.itemDetails}) : super(key: key);

  final WantedWatchModel itemDetails;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser?>(context);
  
   Widget textSection = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "${itemDetails.brand} ${itemDetails.model}",
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
      child: customText(
        "Watch details:",
            fontSize: 18,
              textAlign: TextAlign.start
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

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 30,
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

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Box and Papers: ${itemDetails.boxAndPapers}",
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
        top: 30,
        left: 20,
      ),
      child: Text(
        "Service Records: ${itemDetails.serviceRecords}",
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

    Widget newOrUsed = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "New or Used: ${itemDetails.newOrOld}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget price = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Price: ${itemDetails.price}",
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

    Widget contact = ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "Contact User",
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
            MaterialPageRoute(builder: (context) => Conversation(listItem: itemDetails.userId)),
          );
        },
    );

    Widget userDetails(){
      return Container(
        margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
               customText(
          "User",
              fontSize: 20,
              textAlign: TextAlign.start),
              FutureBuilder(
          future: Users(userId: itemDetails.userId).userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      
            if (snapshot.hasData) {
              UserData userData = UserData.fromDocument(snapshot.data!);
              return Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  right: 20.0,
                ),
                child: Row(
                    children: [
                      Container(
                        child: userData.dp == "default"
                            ? const CircleAvatar(
            radius: 18.0,
            child:Icon(Icons.person,
                    size: 24.0, color: Colors.white,),
          )
                            : CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  imageUrl: userData.dp,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.person),
                                      imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 18.0,
          backgroundImage: imageProvider,
         ),
                                ),
                      ),
      
                      const SizedBox(
                        width: 5.5,
                      ),
                      customText(
                            userData.username,
                                fontSize: 15.0,
                                )
                    ],
                  ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image(
                              image:
                                  Image.asset("assets/images/account_profile.png")
                                      .image),
                        ),
                      ),
      
                      const SizedBox(
                        width: 5.5,
                      ),
                      shimmer(width: 150.0, height: 10.0),
                    ]
                  ),
              );
            }
          }),
      const SizedBox(
                        height: 10.0,
                      ),
          contact
      
            ]
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wanted watch details",
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
            Carousel(images:itemDetails.images,),
            productDetails,
            brand,
            model,
            year,
            boxAndPapers,
            serviceRecords,
            newOrUsed,
            price,
            Visibility(
              visible: itemDetails.userId != user!.uid ? true : false,
              child: 
                  userDetails()),
          ],
        ),
      ),
    );
  }
}
