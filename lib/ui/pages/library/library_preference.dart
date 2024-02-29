import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';
import '../../widgets/dialog.dart';
import '../home/home_screen.dart';

class LibraryPreference extends StatefulWidget {
  const LibraryPreference({Key? key}) : super(key: key);

  @override
  State<LibraryPreference> createState() => LibraryPreferenceState();
}

class LibraryPreferenceState extends State<LibraryPreference> {
  List<String> selectedCollections = List.empty(growable: true);
  final ValueNotifier<bool> isUpdatingPreference = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    final double screenWidth = MediaQuery.of(context).size.width;

    Widget watch = GestureDetector(
      onTap: () {
        if (selectedCollections.contains(AppConstants.watch)) {
          setState(() => selectedCollections.remove(AppConstants.watch));
        } else {
          setState(() => selectedCollections.add(AppConstants.watch));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 50.0),
        width: (screenWidth / 1.5),
        height: (screenWidth / 2.5),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 15.0,
                  ),
                  child: Image.asset(
                    "assets/images/watch.png",
                    width: 70,
                    height: 70,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  "Watch",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1 /*PERCENT not supported*/
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: selectedCollections.contains(AppConstants.watch)
                  ? true
                  : false,
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: const Icon(Icons.check,
                    size: 24.0, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ]),
      ),
    );

    Widget shoe = GestureDetector(
      onTap: () {
        if (selectedCollections.contains(AppConstants.shoe)) {
          setState(() => selectedCollections.remove(AppConstants.shoe));
        } else {
          setState(() => selectedCollections.add(AppConstants.shoe));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 40.0),
        width: (screenWidth / 1.5),
        height: (screenWidth / 2.5),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Image.asset(
                    "assets/images/male_shoe.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  "Shoe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1 /*PERCENT not supported*/
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: selectedCollections.contains(AppConstants.shoe)
                  ? true
                  : false,
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: const Icon(Icons.check,
                    size: 24.0, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ]),
      ),
    );

    Widget bag = GestureDetector(
      onTap: () {
        if (selectedCollections.contains(AppConstants.bag)) {
          setState(() => selectedCollections.remove(AppConstants.bag));
        } else {
          setState(() => selectedCollections.add(AppConstants.bag));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 40.0),
        width: (screenWidth / 1.5),
        height: (screenWidth / 2.5),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 15.0,
                  ),
                  child: Image.asset(
                    "assets/images/bag.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  "Bag",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1 /*PERCENT not supported*/
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible:
                  selectedCollections.contains(AppConstants.bag) ? true : false,
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: const Icon(Icons.check,
                    size: 24.0, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ]),
      ),
    );

    Widget cars = GestureDetector(
      onTap: () {
        if (selectedCollections.contains(AppConstants.car)) {
          setState(() => selectedCollections.remove(AppConstants.car));
        } else {
          setState(() => selectedCollections.add(AppConstants.car));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 40.0,
          bottom: 40.0,
        ),
        width: (screenWidth / 1.5),
        height: (screenWidth / 2.5),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Stack(children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: Image.asset(
                    "assets/images/sedan.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Text(
                  "Car",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1 /*PERCENT not supported*/
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible:
                  selectedCollections.contains(AppConstants.car) ? true : false,
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                child: const Icon(Icons.check,
                    size: 24.0, color: AppColors.backgroundColor),
              ),
            ),
          ),
        ]),
      ),
    );

    Widget next = Container(
      width: (double.infinity),
      margin: const EdgeInsets.only(
        left: 35.0,
        right: 35.0,
        bottom: 20.0,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isUpdatingPreference,
        builder: (context, value, child) {
          return value
              ? const LoadingDialog()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor1,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: const Text(
                    "Continue",
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
                    // save selection to database
                    isUpdatingPreference.value = true;
                    Users(userId: user.id)
                        .updateUserData(
                            "libraryCollections", selectedCollections)
                        .whenComplete(() {
                      isUpdatingPreference.value = false;
                      Navigator.pop(context);
                    });
                  },
                );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Select library collections",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: "Poppins",
              fontSize: 18,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.bold,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const Home();
            }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            watch,
            shoe,
            bag,
            cars,
            Visibility(
                visible: selectedCollections.isNotEmpty ? true : false,
                child: next)
          ]),
        ),
      ),
    );
  }
}
