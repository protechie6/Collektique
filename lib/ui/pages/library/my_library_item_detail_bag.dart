import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/my_library_model.dart';
import '../../widgets/carousel.dart';
import '../common/box_and_papers.dart';
import 'library_item_more_details.dart';

class MyLibraryItemDetailsBag extends StatelessWidget {
  
  const MyLibraryItemDetailsBag({Key? key, required this.itemDetails}) : super(key: key);

  final MyLibraryModel itemDetails;

  @override
  Widget build(BuildContext context) {

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20,
      ),
      child: const Text(
        "Bag details:",
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
      child:  Text(
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

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Box and Papers: ${itemDetails.boxAndPapers.length} image(s)",
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
          IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoxAndPapers(boxAndPapers: itemDetails.boxAndPapers, activity: "Box and Papers",),),
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

    Widget bagSize = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Bag size: ${itemDetails.size}",
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

    Widget condition = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Condition: ${itemDetails.condition}",
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

    Widget ownedFor = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Owned For: ${itemDetails.ownedFor}",
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

    Widget forSale = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "For Sale: ${itemDetails.forSale}",
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

    Widget details = Container(
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
          "More",
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
            MaterialPageRoute(builder: (context) => LibraryItemMoreDetails(details: itemDetails)),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Item details",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Carousel(images:itemDetails.images,),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            bagSize,
            condition,
            ownedFor,
            forSale,
            price,
            details,
          ],
        ),
      ),
    );
  }
}
