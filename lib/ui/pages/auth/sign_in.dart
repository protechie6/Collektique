import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/services/auth_service.dart';
import 'package:watch_vault/utils/ui_utils.dart';
import 'package:watch_vault/ui/widgets/custom_form_field.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';

class LogIn extends StatefulWidget {
  
   final Function route;
  const LogIn({Key? key, required this.route}) : super(key: key);

  @override
  State<LogIn> createState() => LogInState();
}

class LogInState extends State<LogIn> {
  //checkbox
  bool? isChecked = false;

  // loading dialog
  bool isBusy = false;

  //Text field state
  late TextEditingController _emailTextController;
  late TextEditingController _passWordTextController;

//form key
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passWordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passWordTextController.dispose();
    super.dispose();
  }

  void signInUser() async {
    setState(() => isBusy = true);
    dynamic result = await _authService
        .signInWithEmailAndPassword(_emailTextController.text, _passWordTextController.text, context: context);
    if (result == null) {
      if (mounted) {
        setState(() {
          isBusy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget title =  Padding(
      padding: const EdgeInsets.only(
        top: 32,
      ),
      child: customText('Sign in',fontSize: 15, textAlign: TextAlign.start,textColor: AppColors.white),
    );

    Widget text1 =  Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: customText(
        'Please Sign in first to enjoy your \n watch management service it is free',
        fontSize: 12,textColor: AppColors.white),
    );

    Widget eMail = Container(
      margin: const EdgeInsets.only(
        top: 70,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
        isEmail: true,
        controller: _emailTextController,
      validator:(value)=>UiUtils.validateEmail(_emailTextController.text),
      hint:'E-mail')
    );

    Widget passWord = Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
              hint: "Password",
              controller: _passWordTextController,
              isPassword: true,
              validator: (value)=>UiUtils.validatePassword(_passWordTextController.text),
            )
    );

    Widget checkbox = CheckboxListTile(
      value: isChecked,
      side: const BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
      controlAffinity: ListTileControlAffinity.leading, //checkbox at left
      onChanged: (bool? value) {
        setState(() {
          ////TODO SET REMEMBER ME TO SHARED PREFERENCE
          isChecked = value;
        });
      },
      title: customText('Remember me',fontSize: 12, textAlign: TextAlign.start,textColor: AppColors.white),
    );

    Widget row1 = Container(
      margin: const EdgeInsets.only(
        top: 10,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
       SizedBox(
          width: 230, // <-- Fixed width.
          child: checkbox,
        ),
         TextButton(
            onPressed: isBusy?null:() {
              ////TODO forgot password
            },
            child: customText('Forgot password',fontSize: 12,textColor: AppColors.white),
          ),
      ]),
    );

    Widget button = Container(
      margin: const EdgeInsets.only(
        top: 32,
      ),
      child: isBusy? const LoadingDialog(): customButton(
        function: (){
        if (_formKey.currentState!.validate()) {
            signInUser();
          }
      }, child: customText('Sign in',fontSize: 15,textColor: AppColors.white) ),
    );

    Widget signUPButton() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      child: RichText(
        text: TextSpan(
          style: textStyle(fontSize:14.0,),
          children: <TextSpan>[
            const TextSpan(text: 'I don\'t have an account?'),
            TextSpan(
              text: ' Sign Up',
              style: textStyle(fontSize:14.0,),
              recognizer: TapGestureRecognizer()
                ..onTap = isBusy?null:() {
    
                  widget.route('signUp');
                },
            ),
          ],
        ),
      ),
    );
  }

    return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      title,
                      text1,
                      eMail,
                      passWord,
                      row1,
                      button,
                      signUPButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
