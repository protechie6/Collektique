import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:provider/provider.dart';
import 'models/firebase_user.dart';
import 'ui/pages/account/security/passcode.dart';
import 'ui/pages/auth/sign_in.dart';
import 'ui/pages/auth/sign_up.dart';
import 'ui/pages/home/home_screen.dart';
import 'ui/pages/onboarding/welcome_message_screen.dart';
import 'utils/all_constants.dart';
import 'package:watch_vault/utils/shared_preference.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  
  String route = "";
  StreamSubscription<Map>? streamSubscriptionDeepLink;

@override
void initState(){
  listenDeepLinkData();
  super.initState();
}

 @override
  void dispose() {
    super.dispose();
    streamSubscriptionDeepLink?.cancel();
  }

  void toggleRoute(String value) {
      setState(() {
        route = value;
      });
    }

     void listenDeepLinkData() async {
    streamSubscriptionDeepLink = FlutterBranchSdk.initSession().listen((data) {
      if (data.containsKey(AppConstants.clickedBranchLink) &&
          data[AppConstants.clickedBranchLink] == true) {
            //print('Custom data: ${data['link_data']}');
       /* 
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NextScreen(
                      customString: data[AppConstants.deepLinkTitle],
                    )));

                    */
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print('${platformException.code} - ${platformException.message}');
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser?>(context);
    bool isFirstTimeApp =
          SharedPrefs.getBool(AppConstants.isFirstTime) ??
              true;
    if (user == null) {
      if (isFirstTimeApp) {
        switch (route) {
          case "signIn":
            return LogIn(route: toggleRoute);

          case "signUp":
            return SignUp(route: toggleRoute);

          default:
            return WelcomeMessage(route: toggleRoute);
        }
      } else {
        switch (route) {
          case 'signUp':
            return SignUp(route: toggleRoute);

          default:
            return LogIn(route: toggleRoute);
        }
      }
    } else {
      return PassCode(
        isStartUp: true,
        actions: isFirstTimeApp ? 'SET A 4 DIGIT PIN' : 'ENTER PIN',
        isPinCorrect: (bool value) {
          if (value) {
            ////Navigate to Home();
            SharedPrefs.setBool(AppConstants.isFirstTime, false);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          }
        },
      );
    }
  }
}
