import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../utils/shared_preference.dart';

class PaymentDetails extends StatefulWidget {

  const PaymentDetails({Key? key, required this.accountType}) : super(key: key);

  final String accountType;

  @override
  State<PaymentDetails> createState() => PaymentDetailsState();
}

class PaymentDetailsState extends State<PaymentDetails> {

  List<String> cardDetails = ["", "", "", ""];

  String paymentMethod = "";
  String? accountSub;

  @override
  void initState() {
    super.initState();
    _loadCardDetails();
  }

  void _loadCardDetails() async {
    
    bool hasKey = SharedPrefs.contains("cardDetails")??false;
    if (hasKey) {
      setState(() => cardDetails = SharedPrefs.getList("cardDetails")!);
    }

    if(widget.accountType =='PRO'){
      setState(()=>accountSub='1.99');
    }else{
      setState(()=>accountSub='9.99');
    }
  }

  void _selectPayMethod(String method){

    switch(method){

      case "paypal":
      setState((){
        paymentMethod = method;
      });
      break;

      case "apple_pay":
      setState((){
        paymentMethod = method;
      });
      break;

      case "card":
      setState((){
        paymentMethod = method;
      });
      break;

      case "mastercard":
      setState((){
        paymentMethod = method;
      });
      break;
    }
  }

  void paypalPayment(BuildContext context) {
  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                                "AcYAzrdubpTRsQcD_VO0tycLTm1PS-lvKXh6ISxOE_4rDcgqSIQSZC_7VeIqZvzhi3rB1zYUBu30fIjS",
                            secretKey:
                                "EDwmUYdDXxSD-QiON6SlfaCtQx3uE_XJa_QUmxFYIPB3Rtb1T6gg9krpNjinL3L81CrkOzj3xBqtWwU1",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: const [
                              {
                                "amount": {
                                  "total": '10.12',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '10.12',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": '10.12',
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  "shipping_address": {
                                    "recipient_name": "Jane Foster",
                                    "line1": "Travis County",
                                    "line2": "",
                                    "city": "Austin",
                                    "country_code": "US",
                                    "postal_code": "73301",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],note: "Contact us for any questions on your order at vaultwatch@gmail.com.",
                            onSuccess: (Map params) async {
                            },
                            onError: (error) {
                            },
                            onCancel: (params) {
                            },),
                      ),
                    );
}

  @override
  Widget build(BuildContext context) {
    Widget text1 = const Padding(
      padding: EdgeInsets.only(
        top: 5,
      ),
      child: Text(
        "Linked Card",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget card = GestureDetector(
      onTap:(){
        _selectPayMethod('card');
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.blueGrey, spreadRadius: 2)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Visibility(
                    visible: paymentMethod == "card"? true: false,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor1,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.check, size: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "VISA",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.bold,
                        height: 1 /*PERCENT not supported*/
                        ),
                    softWrap: true,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  cardDetails[1],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1 /*PERCENT not supported*/
                      ),
                  softWrap: true,
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "CardHolder",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "Expires",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "CVV",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      cardDetails[0],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      cardDetails[2],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      cardDetails[3],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1 /*PERCENT not supported*/
                          ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    Widget text2 = const Padding(
      padding: EdgeInsets.only(
        top: 30,
      ),
      child: Text(
        "Payment Method",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 18,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.bold,
            height: 1 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget paymentMethods = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap:(){
              _selectPayMethod("paypal");
            },
            child: Stack(
              children: [
                
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  width: 60,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3, color: Colors.blueGrey, spreadRadius: 1)
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/paypal.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Visibility(
                    visible: paymentMethod == "paypal"? true: false,
                    child: Container(
                      margin: const EdgeInsets.only(
                      top:22.0,
                      left:5.0),
                      decoration: const BoxDecoration(
                        color: AppColors.buttonColor1,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.check, size: 12.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              _selectPayMethod('apple_pay');
            },
            child: Stack(children: [
             
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                ),
                width: 60,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.blueGrey, spreadRadius: 1)
                  ],
                ),
                child: Image.asset(
                  "assets/images/apple.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
               Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: paymentMethod == "apple_pay"? true: false,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top:22.0,
                      left:5.0),
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor1,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.check, size: 12.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap:(){
              _selectPayMethod('mastercard');
            }, 
            child: Stack(children: [
              
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                ),
                width: 60,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.blueGrey, spreadRadius: 1)
                  ],
                ),
                child: Image.asset(
                  "assets/images/logos_mastercard.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: paymentMethod == "mastercard"? true: false,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top:22.0,
                      left:5.0),
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor1,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.check, size: 12.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),

          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
            ),
            width: 60,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(blurRadius: 3, color: Colors.blueGrey, spreadRadius: 1)
              ],
            ),
            child: const Icon(Icons.add, size: 18.0, color: Colors.white),
          ),
        ],
      );

    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor1,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        minimumSize: const Size(370, 50), //////// HERE
      ),
      onPressed:() {
        if(paymentMethod ==""){
           ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Select payment method')));
        }
        else{
          switch(paymentMethod){

      case "paypal":

      paypalPayment(context);

      break;

      case "apple_pay":
      ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Still under development')));
      break;

      case "card":
      
      ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Still under development')));
      
      break;

      case "mastercard":
      
      ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Still under development')));
      break;
    }
        }
      },
      child: const Text(
        "Pay",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5),
      )
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Payments",
          textAlign: TextAlign.center,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              text1,
              card,
              text2,
              paymentMethods,
              const Row(children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 30),
                  child: Text(
                    "Add",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1 /*PERCENT not supported*/
                        ),
                    softWrap: true,
                  ),
                )
              ]),
              Container(
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                child: button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
