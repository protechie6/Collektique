import 'package:flutter/material.dart';

class RecentlySearched extends StatefulWidget{
  const RecentlySearched({Key? key}) : super(key: key);


  @override
  State<RecentlySearched> createState() => RecentlySearchedState();

}

class RecentlySearchedState extends State<RecentlySearched>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Recently searched",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: "Poppins",
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
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
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

}