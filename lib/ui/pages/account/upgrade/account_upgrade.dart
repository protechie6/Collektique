import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/services/auth_service.dart';

import '../../transaction/payments_details.dart';
import 'account_package.dart';

class AccountUpgrade extends StatefulWidget {
  const AccountUpgrade({Key? key}) : super(key: key);

  @override
  State<AccountUpgrade> createState() => AccountUpgradeState();
}

class AccountUpgradeState extends State<AccountUpgrade> {
  TextEditingController myController = TextEditingController();
  // Text fields
  String password = "";
  String selectedAccountType = "";

  // password check
  bool _empty = false;

  //isAuhenticating user
  bool loading = false;

  Future? future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPackage()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    setState(() {
      selectedAccountType = "$result";
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserData>(context);

    Widget textsection1 = Text(
      "${user.accountType} PLAN",
      style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Poppins',
          fontSize: 18,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1.5 /*PERCENT not supported*/
          ),
      softWrap: true,
    );
    
    Widget textsection2 = Container(
      margin: const EdgeInsets.only(
        top: 5,
      ),
      child: Text(
        user.accountSub,
        style: const TextStyle(
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
    

    Widget textsection3 = const Padding(
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: Text(
        "Username",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.75),
            fontFamily: 'Poppins',
            fontSize: 14,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget usernameBox =  Container(
        margin: const EdgeInsets.only(
          top: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 15,
            right: 15,
          ),
          child: Text(
            user.username,
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 14,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                ),
          ),
        ),
      );
    

    Widget textsection4 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "Email",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.75),
            fontFamily: 'Poppins',
            fontSize: 14,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget emailBox = Container(
        margin: const EdgeInsets.only(
          top: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 10,
            right: 0,
          ),
          child: TextFormField(
            enabled: false,
            initialValue: user.email,
            style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins'),
          ),
        ),
      );
    

    Widget textsection5 = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: const Text(
        "Password",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.75),
            fontFamily: 'Poppins',
            fontSize: 14,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget passwordBox = Container(
      margin: const EdgeInsets.only(
        top: 5,
      ),
      child: TextField(
        style: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: "*********",
          hintStyle: const TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins'),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          errorText: _empty ? "Enter password" : null,
        ),
        obscureText: true,
        controller: myController,
      ),
    );

    Widget textsection6 = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: const Text(
        "Choose Plan",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.75),
            fontFamily: 'Poppins',
            fontSize: 14,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget accountUpgrade = Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: OutlinedButton(
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )),
              side: MaterialStateProperty.all(const BorderSide(
                  color: Colors.white, width: 1.0, style: BorderStyle.solid))),
          onPressed: () {
            _navigateAndDisplaySelection(context);
          },
          child: Row(
            children: [
              Container(
                  child: selectedAccountType == ""
                      ? Text(
                          user.accountType,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )
                      : Text(
                          selectedAccountType,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )), // <-- Text
              const Spacer(),
              const Icon(
                // <-- Icon
                Icons.arrow_drop_down,
                size: 18.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    
    Widget textsection7 = const Padding(
      padding: EdgeInsets.only(
        left: 0,
        top: 20,
      ),
      child: Text(
        "You can only update plan when card details has been",
        textAlign: TextAlign.center,
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

    Widget textsection8 = const Padding(
      padding: EdgeInsets.only(
        left: 0,
        top: 2,
      ),
      child: Text(
        "Linked. For further assistance you can reach us at",
        textAlign: TextAlign.center,
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

    Widget textsection9 = const Padding(
      padding: EdgeInsets.only(
        left: 0,
        top: 2,
        bottom: 30,
      ),
      child: Text(
        "admin@Collektique.com",
        textAlign: TextAlign.center,
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

    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor1,
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        minimumSize: const Size(370, 40),
      ),
      child: const Text(
        "Upgrade",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5),
      ),
      onPressed: () async{
        // copy email and password then send to other payments
        String password = myController.text;
        if (password.trim().isNotEmpty) {
          setState(() {
            _empty = false;
            loading = true;
            myController.clear();
          });
          await AuthService().reAuthenticateUser(password).then((value) {
            if (value == "wrong-password") {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Account upgrade"),
                  content: const Text("Cannot validate user"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(15),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                ),
              );
            } else if (value == "user-not-found") {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Account upgrade"),
                  content: const Text("There is no user found."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(15),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              setState(() => loading = false);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentDetails(accountType: selectedAccountType,)),
              );
            }
          });
        } else {
          setState(() {
            _empty = true;
            loading = false;
          });
        }
      },
    );

    return loading
        ? const LoadingDialog()
        : Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Account",
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
                              textsection1,
                              textsection2,
                              textsection3,
                              usernameBox,
                              textsection4,
                              emailBox,
                              textsection5,
                              passwordBox,
                              textsection6,
                              accountUpgrade,
                              textsection7,
                              textsection8,
                              textsection9,
                              button,
                            ]),
                      ),
                    ),
          );
  }
}
