
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import '../../../models/firebase_user.dart';
import '../../widgets/text.dart';
import '../sales/sale_section.dart';
import '../serial check/serial_check.dart';
import '../stolen/stolen_items_page.dart';
import 'home tab widgets/library.dart';
import 'home tab widgets/top_assets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {

    UserData user = Provider.of<UserData>(context);

    Widget text1 = Container(
      margin: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: customText('Top Assets',fontSize: 14.0,textAlign: TextAlign.start, textColor: AppColors.white),
    );

    Widget topAssets = SizedBox(
      width: double.infinity,
      height: 150.0,
      child: Card(
        margin: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        child: TopAssets(userId: user.id),
      ),
    );

    Widget text2 = Container(
      margin: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: customText('My Library',fontSize: 14.0,textAlign: TextAlign.start, textColor: AppColors.white),
    );

    Widget text3 = Container(
      margin: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: customText('Others',fontSize: 14.0,textAlign: TextAlign.start, textColor: AppColors.white),
    );

    
    Widget sales = Container(
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SaleSection()),
            );
          },
      child: Card(
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
          child: const Column(
            children: [
              Spacer(),
              ImageIcon(
                AssetImage("assets/images/sales.png"),
                size: 32,
                color: AppColors.backgroundColor,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Sales",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1)),
              Spacer(),
            ],
          ),
        ),
      ),
    );

    Widget serialCheck = Container(
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SerialCheck()),
            );
          },
      child: Card(
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
          child: const Column(
            children: [
              Spacer(),
              ImageIcon(
                AssetImage("assets/images/serial.png"),
                size: 32.0,
                color: AppColors.backgroundColor,
              ),
              SizedBox(height: 20.0),
              Text("Serial check",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1)),
              Spacer(),
            ],
          ),
        ),
      ),
    );

    Widget stolen = Container(
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StolenItems()),
            );
          },
      child: Card(
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
          child: const Column(
            children: [
              Spacer(),
              ImageIcon(
                AssetImage("assets/images/stolen.png"),
                size: 32,
                color: AppColors.backgroundColor,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Stolen",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1)),
              Spacer(),
            ],
          ),
        ),
      ),
    );

    Widget forum = Container(
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 20.0,
      ),
        child: GestureDetector(
          onTap: () {},
      child: Card(
        elevation: 20.0,
        shadowColor: Colors.black,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
          child: const Column(
            children: [
              Spacer(),
              Icon(
                Icons.people,
                size: 32.0,
                color: AppColors.backgroundColor,
              ),
              SizedBox(height: 20.0),
              Text("Forum",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1)),
              Spacer(),
            ],
          ),
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // user's top assets
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            text1,
            topAssets,
          ],
        ),

        // myLibrary
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            text2,
            Library(userId: user.id),
          ],
        ),

        //others
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            text3,
            SizedBox(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  sales,
                  serialCheck,
                  stolen,
                  forum,
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
