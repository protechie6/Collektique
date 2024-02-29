import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';
import '../database_collection/user_notification_service.dart';
import '../utils/ui_utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create a firebaseUser model
  FirebaseUser? _user(User? user) {
    return user != null ? FirebaseUser(user.uid) : null;
  }

// register with email and password
  Future<String?> registerWithEmailAndPassword(String email, String password,
      String username, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a document in the usersCollection with the userId

      UserData userData = UserData(
        username: username,
        search: (username.toLowerCase()),
        email: email,
        id: user!.uid,
        dp: "default",
        accountType: 'BASIC',
        accountSub: 'Free',
        libraryCollections: List.empty(growable: true),
        pin: '0000',
        transactionRecords: List.empty(growable: true),
        insuranceDetail: {
          "insuranceCompany": '',
          "policyNumber": '',
          "email": '',
          "insuranceNumber": '',
        },
      );

      await Users(userId: user.uid).insertUserData(userData).whenComplete(() {
        UserNotificatonService(userId: '').sendNotification(
            user.uid,
            'INBOX',
            'Welcome to watch vault! It is such a thrill to have you onboard to enjoy all that watch vault has to offer.',
            'inbox');
        UserNotificatonService(userId: '').sendNotification(
            user.uid,
            'INBOX',
            'Hi $username! To secure your vault, please do change the default pin which is 0000 to any 4 digit you can trust.',
            'inbox');
      });

      return _user(user)!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        UiUtils.customSnackBar(context, msg: 'Password strenght: weak');
      } else if (e.code == 'email-already-in-use') {
        UiUtils.customSnackBar(context, msg: 'Email is already in use');
      }
      return null;
    } catch (err) {
      UiUtils.customSnackBar(context, msg: err.toString());
      return null;
    }
  }

//sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password,
      {required BuildContext context}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _user(user)!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        UiUtils.customSnackBar(context, msg: 'No user found.');
      } else if (e.code == 'wrong-password') {
        UiUtils.customSnackBar(context,
            msg: 'Wrong email or password provided for that user.');
      }

      return null;
    } catch (error) {
      UiUtils.customSnackBar(context, msg: error.toString());

      return null;
    }
  }

  Future<String> reAuthenticateUser(String password) async {
// Create a credential
    try {
      final user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        UserCredential result =
            await _auth.currentUser!.reauthenticateWithCredential(credential);
        log(_user(result.user)!.uid);
        return _user(result.user)!.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log(e.code);
        return e.code;
      } else if (e.code == 'wrong-password') {
        log(e.code);
        return e.code;
      }
    }
    return "";
  }

  // onAuthChanged user stream
  Stream<FirebaseUser?> get credential {
    return _auth.authStateChanges().map((User? user) => _user(user));
  }

  //sign out
  Future signOutUser() async {
    try {
      return await _auth.signOut();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<String> changePassword(String password, String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        UserCredential result =
            await _auth.currentUser!.reauthenticateWithCredential(credential);
        result.user!.updatePassword(newPassword);
      }
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log(e.code);
        return e.code;
      } else if (e.code == 'wrong-password') {
        log(e.code);
        return e.code;
      }
    }
    return "";
  }
}
