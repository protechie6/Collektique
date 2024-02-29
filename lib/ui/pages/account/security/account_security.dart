import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../../utils/shared_preference.dart';
import '../../../widgets/text.dart';
import 'change_password.dart';
import 'passcode.dart';

class AccountSecurity extends StatefulWidget {
  const AccountSecurity({Key? key}) : super(key: key);

  @override
  State<AccountSecurity> createState() => AccountSecurityState();
}

class AccountSecurityState extends State<AccountSecurity> {

  late bool isCheckedFingerprint;
  bool isCheckedRememberMe = false;

  @override
  void initState() {
    super.initState();
    // retrieve storage data for biometric and remember me in login
    init();
  }

  Future init()async{
  setState(() {
    isCheckedFingerprint = SharedPrefs.getBool(AppConstants.fingerPrint) ?? false;
  });
}

  @override
  Widget build(BuildContext context) {
    Widget changePassword = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40.0),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChangePassword()));
        },
        child: Row(
          children: [
           const Icon(
              // <-- Icon
              Icons.key,
              size: 18.0,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText('Change password', fontSize: 15.0), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget changePin = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40.0),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PassCode(
                        actions: "ENTER OLD PIN", isPinCorrect: (bool value) {
                          if(value){
                            Navigator.pop(context);
                          }
                        },
                      )));
        },
        child: Row(
          children: [
            const Icon(
              // <-- Icon
              Icons.pin,
              size: 18.0,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText('Change pin', fontSize: 15.0,), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget biometrics = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 10.0,
        right: 10.0,
      ),
      child: Row(
        children: [
          const Icon(
            // <-- Icon
            Icons.fingerprint,
            size: 18.0,
            color: AppColors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CheckboxListTile(
              value: isCheckedFingerprint,
              controlAffinity: ListTileControlAffinity.trailing,
              side: const BorderSide(
                  color: Color.fromRGBO(255, 255, 255, 1)), //checkbox at left
              onChanged: (bool? value) {
               
                setState(() {
                  isCheckedFingerprint = value!;
                  SharedPrefs.setBool(AppConstants.fingerPrint, value);
                });
              },
              title: customText(
                "Fingerprint Authentication",
                    fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );

Widget rememberMe = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 10.0,
        right: 10.0,
      ),
      child: Row(
        children: [
          const Icon(
            // <-- Icon
            Icons.remember_me,
            size: 18.0,
            color: AppColors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CheckboxListTile(
              value: isCheckedRememberMe,
              controlAffinity: ListTileControlAffinity.trailing,
              side: const BorderSide(
                  color: Color.fromRGBO(255, 255, 255, 1)), //checkbox at left
              onChanged: (bool? value) {
                setState(() {
                  isCheckedRememberMe = value!;
                });
              },
              title: const Text(
                "Remember me",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          "Security",
              fontSize: 16,),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            changePassword,
            changePin,
            biometrics,
            rememberMe,
          ],
        ),
      ),
    );
  }
}
