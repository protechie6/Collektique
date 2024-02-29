import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

class WelcomeScreen extends StatelessWidget {

   const WelcomeScreen({Key? key, required this.route}) : super(key: key);

  final Function route;

  @override
  Widget build(BuildContext context) {
    
    final double screenHeight = MediaQuery.of(context).size.height;
    
    final double screenWidth = MediaQuery.of(context).size.width;

    final double imageHeight = screenHeight / 2;

    Widget textSection = const Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        bottom: 8,
      ),
      child: Text(
        "Welcome To My Watch Vault",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 22,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget textSection2 = const Padding(
      padding: EdgeInsets.only(
        left: 20,
        bottom: 64,
      ),
      child: Text(
        "Watch management made easy",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget image = Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Image.asset(
        "assets/images/image_7.png",
        width: screenWidth,
        height: imageHeight,
        fit: BoxFit.cover,
      ),
    );

    Widget button = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          foregroundColor: Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(250, 40), //////// HERE
        ),
        child: const Text("Get started",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () {
          route("login");
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            image,
            textSection,
            textSection2,
            button,
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
