import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../widgets/text.dart';

class SignUpPackage extends StatefulWidget {
  const SignUpPackage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpPackageState();
}

class SignUpPackageState extends State<SignUpPackage> {
  int currentPage = 0;
  String selectedPackage = "";

  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 8,
      ),
      child: customText(
        "Package",
        fontSize: 18,
      ),
    );

    Widget text1 = Padding(
      padding: const EdgeInsets.only(
        left: 0,
        top: 10,
      ),
      child: customText(
        "Please select your prefered package",
        fontSize: 12,
      ),
    );

    BoxDecoration boxDecoration = BoxDecoration(
      color: AppColors.buttonColor1,
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
    );

    Widget packageTitle(String text) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: customText(
          text,
          fontSize: 18,
        ),
      );
    }

    Widget packageItem(String text) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Container(
                width: 5,
                height: 5,
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
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    Widget freePackage = Container(
      //width: containerHeight,
      margin: const EdgeInsets.only(
        top: 40.0,
        bottom: 40.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              packageTitle(AppConstants.basic),
              packageItem("Library listings for Watches, Cars, Bags and Shoes"),
              packageItem(
                  "Includes: Sold, Previously Owned, Wanted and Stolen"),
              packageItem("3x Library Listings"),
              packageItem("5x Image Uploads per item"),
              packageItem("Chat Functionality to communicate to other users"),
              packageItem("Estimated Collection Value"),
              packageItem(
                  "Watch Serial Database – Rolex only (expanding 2025 to other brands)"),
              packageItem(
                  "Share your Library Items with other minded collectors"),
              packageItem("Browse Sales and Wanted Sections"),
              packageItem("2 € to list Item for sale"),
              packageItem(
                  "10 € to 20 € (depending on value) to transfer Item sold item to buyers User Library"),
              packageItem(
                  "Report and view any stolen watches reported by users on our database"),
              packageItem(
                  "Send Stolen watch information to Insurance and Police"),
              Align(
                alignment: Alignment.bottomCenter,
                child: packageTitle("FREE"),
              ),
            ],
          ),
        ),
      ),
    );

    Widget proPackage = Container(
        //width: containerHeight,
        margin: const EdgeInsets.only(
          top: 40.0,
          bottom: 40.0,
          right: 20,
          left: 20,
        ),
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                packageTitle(AppConstants.pro),
                packageItem(
                    "Library listings for Watches, Cars, Bags and Shoes"),
                packageItem(
                    "Includes: Sold, Previously Owned, Wanted and Stolen"),
                packageItem("10x Library Listings"),
                packageItem("15x Image Uploads per item"),
                packageItem("Chat Functionality to communicate to other users"),
                packageItem("Estimated Collection Value"),
                packageItem(
                    "Watch Serial Database – Rolex only (expanding 2025 to other brands)"),
                packageItem(
                    "Share your Library Items with other minded collectors"),
                packageItem("Browse Sales and Wanted Sections"),
                packageItem("Free to list Item for sale"),
                packageItem(
                    "10 € to 20 € (depending on value) to transfer Item sold item to buyers User Library"),
                packageItem(
                    "Report and view any stolen watches reported by users on our database"),
                packageItem(
                    "Send Stolen watch information to Insurance and Police"),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: packageTitle("£1.99"),
                ),
              ],
            ),
          ),
        ));

    Widget platinumPackage = Container(
      //width: containerHeight,
      margin: const EdgeInsets.only(
        top: 40.0,
        bottom: 40.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              packageTitle(AppConstants.platinum),
              packageItem("App and Web Based App for larger inventories"),
              packageItem("5x User Admin Logins"),
              packageItem("Library listings for Watches, Cars, Bags and Shoes"),
              packageItem(
                  "Includes: Sold, Previously Owned, Wanted and Stolen"),
              packageItem("Unlimited Library Listings"),
              packageItem("Unlimited Image Uploads per item"),
              packageItem("Chat Functionality to communicate to other users"),
              packageItem("Estimated collection value"),
              packageItem(
                  "Watch Serial Database – Rolex only (expanding 2025 to other brands)"),
              packageItem(
                  "Share your Library Items with other minded collectors"),
              packageItem("Browse Sales and Wanted Sections"),
              packageItem("Free to list Item for sale"),
              packageItem(
                  "10 € flat rate to transfer Item sold item to buyers User Library"),
              packageItem(
                  "Report and view any stolen watches reported by users on our database"),
              packageItem(
                  "Send Stolen watch information to Insurance and Police"),
              Align(
                alignment: Alignment.bottomCenter,
                child: packageTitle("£19.99"),
              ),
            ],
          ),
        ),
      ),
    );

    Widget selectedSlide = Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        bottom: 10.0,
      ),
      child: customText(
        "${currentPage + 1} Of 3",
        fontSize: 14,
      ),
    );

    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor1,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        minimumSize: const Size(370, 50), //////// HERE
      ),
      onPressed: () {
        Navigator.pop(context, selectedPackage);
      },
      child: customText(
        "Select",
        fontSize: 16,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            title,
            text1,
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                    switch (currentPage) {
                      case 0:
                        selectedPackage = "BASIC";
                        break;

                      case 1:
                        selectedPackage = "PRO";
                        break;

                      case 2:
                        selectedPackage = "PLATINUM";
                        break;
                    }
                  });
                },
                children: [
                  freePackage,
                  proPackage,
                  platinumPackage,
                ],
              ),
            ),
            selectedSlide,
            button,
            // packages,
          ],
        ),
      ),
    );
  }
}
