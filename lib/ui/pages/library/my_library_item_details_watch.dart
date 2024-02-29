import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/my_library_model.dart';

import '../../../database_collection/users.dart';
import '../../../models/firebase_user.dart';
import '../../widgets/button.dart';
import '../../widgets/carousel.dart';
import '../../widgets/simpleton.dart';
import '../../widgets/text.dart';
import '../common/box_and_papers.dart';
import 'library_item_more_details.dart';

class MyLibraryItemDetailsWatch extends StatelessWidget {
  
  const MyLibraryItemDetailsWatch({Key? key, required this.itemDetails,}) : super(key: key);

  final MyLibraryModel itemDetails;

  @override
  Widget build(BuildContext context) {
    
final user = Provider.of<FirebaseUser?>(context);

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20,
      ),
      child: customText(
        "Watch details:",
            fontSize: 20,),
    );

    Widget brand = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child:  customText(
        "Brand: ${itemDetails.brand}",
            fontSize: 15,),
    );

    Widget model = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Model: ${itemDetails.model}",
            fontSize: 15,
      ),
    );

    Widget serialNumber = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Serial Number: ${itemDetails.serialNumber}",
            fontSize: 15,
      ),
    );

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Year: ${itemDetails.year}",
            fontSize: 15,
      ),
    );

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child:  Row(
        children: [
          customText(
            "Box and Papers: ${itemDetails.boxAndPapers.length} image(s)",
                fontSize: 15,
          ),const Spacer(),
          IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoxAndPapers(boxAndPapers: itemDetails.boxAndPapers, activity: "Box and Papers",)),
            );
          },
          icon: const Icon(
            // <-- Icon
            Icons.image,
            size: 18.0,
            color: Colors.white,
          ),
        ),
        ],
      ),
    );

    Widget insured = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Insured: ${itemDetails.insured}",
            fontSize: 15,
      ),
    );

    Widget serviceRecords = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        children: [
          customText(
            "Service Records: ${itemDetails.serviceRecord.length} image(s)",
                fontSize: 15,
          ),
          const Spacer(),
          IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoxAndPapers(boxAndPapers: itemDetails.serviceRecord, activity: 'Service Records',)),
            );
          },
          icon: const Icon(
            // <-- Icon
            Icons.image,
            size: 18.0,
            color: Colors.white,
          ),
        ),
        ],
      ),
    );

    Widget ownedFor = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Owned For: ${itemDetails.ownedFor}",
            fontSize: 15,
      ),
    );

    Widget forSale = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "For Sale: ${itemDetails.forSale}",
            fontSize: 15,
      ),
    );

    Widget price = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: customText(
        "Price: ${itemDetails.price}",
            fontSize: 15,
      ),
    );

    Widget userDetails(){
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
             customText(
        "User",
            fontSize: 20,),
            FutureBuilder(
        future: Users(userId: itemDetails.userId).userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasData) {
            UserData userData = UserData.fromDocument(snapshot.data!);
            return Container(
              margin: const EdgeInsets.only(
                top: 10,
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
                top: 10.0,
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
        })
          ]
        );
    }

    Widget extras = Container(
        width: (double.infinity),
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 20,
        ),
        child: itemDetails.userId != user!.uid?
        userDetails():
        customButton(
            backgroundColor: AppColors.buttonColor1,
            elevation: 2,
          child: customText(
            "More",
              fontSize: 12,
          ),
          function: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LibraryItemMoreDetails(details: itemDetails)),
            );
          },
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: customText(
          " Item details",
              fontSize: 15,),
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
             Carousel(images:itemDetails.images,),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            insured,
            serviceRecords,
            ownedFor,
            forSale,
            price,
           extras
          ],
        ),
      ),
    );
  }
}
