import 'package:flutter/material.dart';
import 'package:watch_vault/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import '../../../utils/all_constants.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/dialog.dart';
import '../../widgets/text.dart';
import '../../../utils/ui_utils.dart';
import '../common/terms_and_conditions.dart';

class SignUp extends StatefulWidget {
  
  final Function route;
  
  const SignUp({Key? key, required this.route}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  //authService
  final AuthService _authService = AuthService();

  //Text field state
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _usernameTextController;
  late TextEditingController _confirmPasswordTextController;

  //checkbox
  ValueNotifier<bool> isChecked = ValueNotifier(false);

  //loading dialog
  bool isBusy = false;

  final _formKey = GlobalKey<FormState>();

  @override 
  void initState(){
     _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _usernameTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    super.initState();
  }

  @override 
  void dispose(){
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _usernameTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  Future<void> _navigateToTermsAndConditions()async{
    final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditions(action: 'registration',),
            ),
          );
          if (!mounted) return;
          if(result.toString()=='I agree'){
            isChecked.value = true;
          }else{
            isChecked.value = false;
          }
          
  }

  @override
  Widget build(BuildContext context) {

    Widget title =  Padding(
      padding: const EdgeInsets.only(
        top: 32,
      ),
      child: customText("Sign Up",fontSize:15.0),
    );

    Widget text1 = const Padding(
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: Text(
        "Please sign up first to enjoy your",
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
    );

    Widget text2 = const Padding(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Text(
        "watch management service it is free",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 11,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget userName = Container(
      margin: const EdgeInsets.only(
        top: 32,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
        controller: _usernameTextController,
      validator:(value)=>UiUtils.validateName(_usernameTextController.text),
      hint:'Username')
    );

    Widget eMail = Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
        isEmail: true,
        controller: _emailTextController,
      validator:(value)=>UiUtils.validateEmail(_emailTextController.text),
      hint:'E-mail'),
    );

    Widget passWord = Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
        isPassword: true,
        controller: _passwordTextController,
      validator:(value)=>UiUtils.validatePassword(_passwordTextController.text),
      hint:'Password'),
    );

    Widget confirmPassWord = Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: CustomFormField(
        isPassword: true,
        controller: _confirmPasswordTextController,
      validator:(value)=>value!=_passwordTextController.text?'Does not match':null,
      hint:'Confirm Password'),
    );

    Widget checkbox = Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isChecked,
        builder: (BuildContext context, bool value, Widget? child) {
          return CheckboxListTile(
            value: value,
            side: const BorderSide(color: AppColors.white),
            controlAffinity: ListTileControlAffinity.leading, //checkbox at left
            onChanged: (bool? value) {
              _navigateToTermsAndConditions();
            },
            title: customText(
              "I agree with terms and conditions",
              fontSize: 14,
              textAlign: TextAlign.start,
            ));
        },
      ),
    );

    Widget button(){
      return isBusy? const LoadingDialog(): customButton(
      child: customText("Sign Up",fontSize:15.0),
      function: () async {
        //get textfield values
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          if(isChecked.value){
            setState(() => isBusy = true);
          dynamic result = await _authService
              .registerWithEmailAndPassword(_emailTextController.text,
               _passwordTextController.text,
                _usernameTextController.text, context);
          if (result == null) {
            if(mounted){
              setState(() {
              isBusy = false;
            });
            }
          }

          }else{
            UiUtils.customSnackBar(context, msg: 'You must agree to the terms and conditions before you can register!');
          }
        }
      },
    );
    }

    Widget text3 = Container(
      margin:const EdgeInsets.only(top:30.0),
      child: RichText(
          text: TextSpan(
            style: textStyle(fontSize:14.0,),
            children: <TextSpan>[
              const TextSpan(text: 'I already have an account?'),
              TextSpan(
                text: ' Sign in',
                style: textStyle(fontSize:14.0,),
                recognizer: TapGestureRecognizer()
                  ..onTap = isBusy?null:() {
       widget.route('signIn');
                  },
              ),
            ],
          ),
        ),
    );

    return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    title,
                    text1,
                    text2,
                    userName,
                    eMail,
                    passWord,
                    confirmPassWord,
                    checkbox,
                    button(),
                    text3,
                  ],
                ),
              )),
            ),
          );
  }
}
