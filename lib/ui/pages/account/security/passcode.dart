import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';
import 'package:watch_vault/ui/widgets/num_pad.dart';
import '../../../../../ui/widgets/dialog.dart';
import '../../../../utils/shared_preference.dart';
import '../../../../utils/ui_utils.dart';
import '../../../widgets/text.dart';

class PassCode extends StatefulWidget {
  const PassCode({Key? key, required this.actions,
    required this.isPinCorrect, this.isStartUp= false}) : super(key: key);

  final String actions;
  final ValueChanged<bool> isPinCorrect;
  final bool isStartUp;

  @override
  State<PassCode> createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {

  final LocalAuthentication auth = LocalAuthentication();
  
  // text controller
  final TextEditingController _myController = TextEditingController();
  bool isCorrectPin = false;
  String initialPin = "";
  String? title;
  bool isNewPin = false;
  bool isLoading = false;
  late bool isFingerPrintEnabled;
  late UserData user;
 late bool isStartUp;

  @override
  void initState() {
    super.initState();
    title = widget.actions;
    isStartUp = widget.isStartUp;
    isFingerPrintEnabled = SharedPrefs.getBool(AppConstants.fingerPrint) ?? false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserData>(context);
  }

  void setPin() {
    if (isCorrectPin) {
      String pin = _myController.text;
      if (pin == initialPin) {
        //saved to database
Users(userId: user.id).updateUserData("pin",pin)
        .whenComplete(() =>setPinSuccess());
        
      } else {
        incorrectPin();
      }
    } else {
      //prompt to enter pin
      setState(() {
        isCorrectPin = true;
        initialPin = _myController.text;
        title = "CONFIRM PIN";
        _myController.clear();
      });
    }
  }

  void enterPin() {
    if (_myController.text == user.pin) {
      setState(() {
            widget.isPinCorrect(true);
            title = "";
            isLoading = true;
          });
    }else{
      // do a timer lock after 4 trials
      incorrectPin();
    }
  }

  void changePin() {
    if (isNewPin) {
      setPin();
    } else {
      //verify old pin
      if (_myController.text == user.pin) {
        setState(() {
          isNewPin = true;
          title = "ENTER A NEW 4 DIGIT PIN";
          _myController.clear();
        });
      }else{
      // do a timer lock after 4 trials
      incorrectPin();
    }
    }
  }
  
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      debugPrint(e.message);
    }
    if (!mounted) {
      return;
    }
    if (canCheckBiometrics) {
      _authenticateWithBiometrics();
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to sign in',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return;
    }
    if (!mounted) {
      return;
    }
    if (authenticated) {
      // isSuccessfull
      setState(() {
            widget.isPinCorrect(true);
            title = "";
            isLoading = true;
          });
    }
  }

  Widget biometric(){
    return Container(
       margin: const EdgeInsets.only(top:30.0),
      child: IconButton(
              onPressed: () {
                if (isFingerPrintEnabled) {
                  _checkBiometrics();
                } else {
                  UiUtils.customSnackBar(context, msg: 'Not enabled. Go to ACCOUNT-Security');
                }
              },
              icon: const Icon(
                Icons.fingerprint,
                size: 32.0,
                color: AppColors.white,
              ),
            ),
    );
  }

  Widget forgotPin(){
    return Container(
              margin: const EdgeInsets.only(top:20.0),
              child: TextButton(
                onPressed: (){
                  ////TODO forgot pin
                },
               child: customText('Forgot pin?',fontSize: 16.0, textColor: AppColors.white),
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(title!,fontSize: 16.0, textColor: AppColors.white),
            leading:isStartUp?null:IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        elevation: 0,
      ),
      body: isLoading? const LoadingDialog()
      : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // display the entered numbers
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: TextField(
                    //maxLength: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: _myController,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    style: const TextStyle(
                        fontSize: 60,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                    // Disable the default soft keybaord
                    keyboardType: TextInputType.none,
                    obscureText: true,
                    onChanged: (value){
                      if(value.length>4){
                       _myController.clear();
                      }
                    },
                  ),
                ),
              ),
            // implement the custom NumPad
            NumPad(
              buttonSize: 64,
              buttonColor: AppColors.buttonColor1,
              iconColor: AppColors.buttonColor1,
              controller: _myController,
              delete: () {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              },
              // do something with the input numbers
              onSubmit: () {
                //debugPrint('Your code: ${_myController.text}');
                if (_myController.text.length == 4) {
                  switch (widget.actions) {
                    case "SET A 4 DIGIT PIN":
                      setPin();
                      break;
      
                    case "ENTER OLD PIN":
                      changePin();
                      break;
      
                    default:
                      enterPin();
                      break;
                  }
                }
              },
            ),
            forgotPin(),

            biometric(),

          ],
        ),
      ),
    );
  }
  
  setPinSuccess() {
    showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Success"),
                    content:
                        const Text("Your pin has been set!",
                    style:  TextStyle(
              color: AppColors.backgroundColor,
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            ),
                 ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                         setState(() {
            widget.isPinCorrect(true);
            title = "";
            isLoading = true;
          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: const Text("Okay",
                    
                    style:  TextStyle(
              color: AppColors.backgroundColor,
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            ),
                 ),
                        ),
                      ),
                    ],
                  ),
                );
  }
  
  void incorrectPin() {
    
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text(
                    "Incorrect",
                    style:  TextStyle(
              color: AppColors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            ),
                  ),
                ));
  }
}
