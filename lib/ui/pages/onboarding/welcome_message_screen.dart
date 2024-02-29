import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../widgets/text.dart';

class WelcomeMessage extends StatefulWidget {

  final Function route;

  const WelcomeMessage({Key? key, required this.route}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WelcomeMessageState();
}

class WelcomeMessageState extends State<WelcomeMessage> {
  int currentPage = 0;
  String slide = "";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget title =  Padding(
      padding: const EdgeInsets.only(top: 120, left: 20.0),
      child: customText(
       AppConstants.appName,
            fontSize: 24,
      ),
    );

    Widget text1 =  Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20,
      ),
      child: customText(
        "The easiest and safest place to :",
            fontSize: 18,
      ),
    );

    BoxDecoration boxDecoration = const BoxDecoration(
      color: AppColors.buttonColor1,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    );

    Widget packageItem(String text) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: customText(
                text,
                    fontSize: 16,
                maxLines: 2,
              ),
            ),
          ],
        ),
      );
    }

    Widget slide1 = Container(
      margin: const EdgeInsets.all(20.0),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            packageItem("Store all your watch collection information"),
            packageItem(
                "Upload images, service receipts and any documentation"),
          ],
        ),
      ),
    );

    Widget slide2 = Container(
        margin: const EdgeInsets.all(20.0),
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              packageItem("Share watch information with users"),
              packageItem("Buy, sell and request wanted watches"),
            ],
          ),
        ));

    Widget slide3 = Container(
      margin: const EdgeInsets.all(20.0),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            packageItem("Communicate with member through chat"),
            packageItem("Serial check watches"),
          ],
        ),
      ),
    );

    Widget slide4 = Container(
      margin: const EdgeInsets.all(20.0),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            packageItem("Report and track stolen watches"),
            packageItem("and so much more!"),
          ],
        ),
      ),
    );

    Widget selectedSlide = Center(
      child: SizedBox(
        width: 100,
        child: Row(
          children: [
            Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: currentPage == 0 ? AppColors.white : Colors.blueGrey,
                  borderRadius: const BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(
                  right: 10,
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  color: currentPage == 1 ? AppColors.white : Colors.blueGrey,
                  borderRadius: const BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(
                  right: 10,
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  color: currentPage == 2 ? AppColors.white : Colors.blueGrey,
                  borderRadius: const BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                decoration: BoxDecoration(
                  color: currentPage == 3 ? AppColors.white : Colors.blueGrey,
                  borderRadius: const BorderRadius.all(Radius.elliptical(5, 5)),
                )),
          ],
        ),
      ),
    );

    Widget nextButton = Visibility(
      visible: currentPage == 3 ? true : false,
      child: Container(
        margin: const EdgeInsets.only(right: 20.0, top: 20.0, bottom: 20.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor1,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              minimumSize: const Size(100, 45), //////// HERE
            ),
            onPressed: () {
              widget.route('signUp');
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            )),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            title,
            text1,
            const Spacer(),
            SizedBox(
                width: (screenWidth / 1.0),
                height: (screenWidth / 1.5),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  children: [
                    slide1,
                    slide2,
                    slide3,
                    slide4,
                  ],
                )),
            const Spacer(),
            selectedSlide,
            const Spacer(),
            Row(children: [
              const Spacer(),
              nextButton,
            ]),
          ],
        ),
      ),
    );
  }
}
