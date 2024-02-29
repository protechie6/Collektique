// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:watch_vault/ui/widgets/carousel.dart';

import '../message/chat_lists.dart';
class PreviouslyOwnedWatchDetails extends StatelessWidget {
  const PreviouslyOwnedWatchDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    
    Widget textSection = Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text(
        "IVC CHROMO",
        textAlign: TextAlign.center,
        style: TextStyle(
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
        "Product details:",
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
      child: const Text(
        "Brand: IVC",
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

    Widget model = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Model: Portuguese",
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

    Widget serialNumber = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Serial Number: 4234761223",
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

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Year: 2008",
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

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Box and Papers: Yes",
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

Widget dateOfSale = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Date of Sale: 18/05/2022",
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

    Widget serviceRecords = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Service Records: No",
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

    Widget soldTo = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Sold To: Marky Mark",
        style: TextStyle(
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

    Widget soldPrice = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: const Text(
        "Sold Price: \$ 4700",
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


    Widget contact = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(51, 153, 153, 1),
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
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentDetails2()),
          );*/
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
                    color: Color.fromRGBO(32, 72, 72, 1),
                  ),
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentDetails2()),
          );*/
        },
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 72, 72, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(32, 72, 72, 1),
        title: const Text("Previous watch details",
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatList()),
                  );
                },
                child: const ImageIcon(
                  AssetImage("assets/images/msg_icon.png"),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textSection,
           const Carousel(images: [],),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            dateOfSale,
            serviceRecords,
            soldTo,
            soldPrice,
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
