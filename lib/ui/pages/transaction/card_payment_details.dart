import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => PaymentState();
}

class PaymentState extends State<Payments> {
  //Text field state
  String cardNumber = "";
  String expiryDate = "";
  String cvvNumber = "";
  String cardHolder = "";

//form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget textsection1 = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: const Text(
        "Connect a Debit Card",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 20.0,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget textsection2 = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: const Text(
        "Make sure that the card belongs to you",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 13,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget cardHolderText = Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: const Text(
        "Card Holder",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget cardHolderTextField = Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(255, 255, 255, 1), width: 1),
          ),
          hintText: 'John Doe',
          hintStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(255, 255, 255, 1), width: 1),
          ),
        ),
        onChanged: (value) {
          setState(() => cardHolder = value);
        },
        validator: ((value) =>
            value!.trim().isEmpty ? "Enter card holder!" : null),
      ),
    );


    Widget cardNumberText = Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: const Text(
        "Card Number",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget cardNumberTextField = Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: TextFormField(
        maxLength: 16,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(255, 255, 255, 1), width: 1),
          ),
          hintText: '****  ****  ****  ****',
          hintStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(255, 255, 255, 1), width: 1),
          ),
        ),
        onChanged: (value) {
          setState(() => cardNumber = value);
        },
        validator: ((value) =>
            value!.trim().isEmpty ? "Enter card number!" : null),
      ),
    );

    Widget expiry = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "Expiry",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: TextFormField(
            maxLength: 5,
            style: const TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1), width: 1),
              ),
              hintText: "MM/YY",
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5 /*PERCENT not supported*/
                  ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1), width: 1),
              ),
            ),
            onChanged: (value) {
              setState(() => expiryDate = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter expiry date !" : null),
          ),
        )
      ],
    );

    Widget cvv = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "CVV",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: TextFormField(
            maxLength: 3,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1), width: 1),
              ),
              hintText: "***",
              hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5 /*PERCENT not supported*/
                  ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1), width: 1),
              ),
            ),
            obscureText: false,
            onChanged: (value) {
              setState(() => cvvNumber = value);
            },
            validator: ((value) =>
                value!.length < 3 ? "Minimum character is 3" : null),
          ),
        )
      ],
    );

    Widget button = Container(
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          minimumSize: Size(screenWidth, 50),
        ),
        child: const Text(
          "Add Card",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 18,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5),
        ),
        onPressed: ()async {
          if (_formKey.currentState!.validate()) {
          // Obtain shared preferences.
//final prefs = await SharedPreferences.getInstance();
//await prefs.setStringList('cardDetails', <String>[cardHolder, cardNumber, expiryDate, cvvNumber]).then((value){
//  Navigator.pop(context);
//});
          }
        },
      ),
    );

    return Scaffold(
      appBar:AppBar(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20, right:20.0, bottom:20.0,top:5.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  textsection1,
                  textsection2,
                  cardHolderText,
                  cardHolderTextField,
                  cardNumberText,
                  cardNumberTextField,
                  Row(
                    children: [
                      SizedBox(
                        width: (screenWidth / 2.5),
                        child: expiry,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: (screenWidth / 2.5),
                        child: cvv,
                      ),
                    ],
                  ),
                  button,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
