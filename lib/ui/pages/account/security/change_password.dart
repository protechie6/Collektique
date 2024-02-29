import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/services/auth_service.dart';

import '../../../../../ui/widgets/dialog.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  //authService
  final AuthService _authService = AuthService();

  //Text field state
  String currentPassword = "";
  String password = "";
  String username = "";

  //sign up error
  String error = "";

  //checkbox
  bool? isChecked = false;

  //loading dialog
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isChangingPassword = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Widget oldPassword = Container(
      margin: const EdgeInsets.only(
        top: 50,
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          labelText: "Old password",
          labelStyle: TextStyle(
              fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1)),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
        obscureText: true,
        onChanged: (value) {
          setState(() => currentPassword = value);
        },
        validator: ((value) =>
            value!.length < 8 ? "Minimum character is 8" : null),
      ),
    );

    Widget passWord = Container(
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          labelText: "New password",
          labelStyle: TextStyle(
              fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1)),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
        obscureText: true,
        onChanged: (value) {
          setState(() => password = value);
        },
        validator: ((value) =>
            value!.length < 8 ? "Minimum character is 8" : null),
      ),
    );

    Widget confirmPassWord = Container(
      margin: const EdgeInsets.only(
        top: 30.0,
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          labelText: "Confirm new password",
          labelStyle: TextStyle(
              fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1)),
          enabledBorder: UnderlineInputBorder(
            //<-- SEE HERE
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
        obscureText: true,
        validator: ((value) =>
            value != password ? "Password do not match" : null),
      ),
    );

    Widget button = Container(
      margin: const EdgeInsets.only(
        top: 70,
        left: 20,
        right: 20,
      ),
      child: ValueListenableBuilder<bool>(
          valueListenable: isChangingPassword,
          builder: (context, value, child) {
            return value
                ? const LoadingDialog()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor1,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      minimumSize: const Size(250, 40), //////// HERE
                    ),
                    child: const Text("Change",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1 /*PERCENT not supported*/
                            )),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        isChangingPassword.value = true;

                        await _authService
                            .changePassword(currentPassword, password)
                            .then((value) {
                          //isChangingPassword is set to false;
                          isChangingPassword.value = false;

                          // Display a snackbar to show the result
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text("Password change ${value.toString()}"),
                              backgroundColor: AppColors.buttonColor1,
                              padding: const EdgeInsets.all(20.0),
                            ));
                        });
                      }
                    },
                  );
          }),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Change password",
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
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            oldPassword,
            passWord,
            confirmPassWord,
            button,
          ],
        ),
      )),
    );
  }
}
