import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/firebase_user.dart';
import 'card_payment_details.dart';

class Transaction extends StatefulWidget{
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState()=> _TransactionState();
}

class _TransactionState extends State<Transaction>{

  @override
  Widget build(BuildContext context){

    Widget connectADebitCard(){
      return OutlinedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Payments()));
      },
      style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.white, width: 1),
      maximumSize: const Size(250.0,100.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
     
    ),
      child: const Center(
        child: Text(
              'Connect a debit card',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: 'Poppins'),
            ),
      ),
    ); 
    }

    Widget transactionRecords(){
      UserData user = Provider.of<UserData>(context);
      List<List<String>> records = user.transactionRecords;
      return ListView.builder(
        itemCount: records.length,
        itemBuilder: (context,index) {
        return Container();
  });
    }

    Widget body(){
      return Column(
        children: [
          const SizedBox(height: 50.0,),
          connectADebitCard(),
          const SizedBox(height: 50.0,),
          const Text(
              'Recents',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20.0,),
          Expanded(child: transactionRecords(),
          )
        ],
      );
    }
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: const Text(
          "Transaction",
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
      body: body(),
    );
  }
}