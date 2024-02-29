import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/auth_wrapper.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:watch_vault/services/auth_service.dart';
import 'package:watch_vault/theme.dart';
import 'firebase_options.dart';
import 'database_collection/users.dart';
import 'package:watch_vault/utils/shared_preference.dart';
//import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FlutterBranchSdk.validateSDKIntegration();

  // Initialize SharedPrefs instance.
  await SharedPrefs.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().credential,
      initialData: FirebaseUser.initialData(), 
      builder: (context, child) {
        if(context.watch<FirebaseUser?>() != null){
        return StreamProvider<UserData>.value(
          initialData: UserData.initialData(),
           value: Users(userId: context.watch<FirebaseUser?>()!.uid).currentUserData,
           child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const AuthWrapper(),
      ),);
        }else{
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const AuthWrapper(),
      );
        }
      },
    );
  }
}
