import 'package:flutter/material.dart';

import '../message/chat_lists.dart';

class PreviouslyOwned extends StatefulWidget {
  const PreviouslyOwned({Key? key}) : super(key: key);

  @override
  State<PreviouslyOwned> createState() => PreviouslyOwnedState();
}

class PreviouslyOwnedState extends State<PreviouslyOwned> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous watches",
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
      body: const Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
