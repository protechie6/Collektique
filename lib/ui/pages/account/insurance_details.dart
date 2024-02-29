import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database_collection/users.dart';
import '../../../models/firebase_user.dart';
import '../../../utils/ui_utils.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/text.dart';

class InsuranceDetails extends StatefulWidget{
  const InsuranceDetails({Key? key}) : super(key: key);

  @override
  State<InsuranceDetails> createState()=>InsuranceDetailsState();
  }

class InsuranceDetailsState extends State<InsuranceDetails>{

   //Text field state
  late TextEditingController _nameTextController;
  late TextEditingController _policyNumberTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _insuranceNumberTextController;
  bool action = false;
  late UserData user;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserData>(context);
    InsuranceDetail detail = InsuranceDetail.fromJson(user.insuranceDetail);

     _nameTextController= TextEditingController(text:detail.insuranceCompany);
  _policyNumberTextController= TextEditingController(text:detail.policyNumber);
  _emailTextController= TextEditingController(text:detail.email);
  _insuranceNumberTextController= TextEditingController(text:detail.insuranceNumber);
  }

  @override
  void dispose(){
    _nameTextController.dispose();
  _policyNumberTextController.dispose();
  _emailTextController.dispose();
  _insuranceNumberTextController.dispose();
    super.dispose();
  }

  body(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            //Insurance company name
            CustomFormField(
              isEnable: action,
                    hint: "Insurance company",
                    controller: _nameTextController,
                    validator: (value)=>UiUtils.validateName(_nameTextController.text),
                  ),
              
                  const SizedBox(height:50.0),
              
                  CustomFormField(
                    isEnable: action,
                    hint: "Policy number",
                    controller: _policyNumberTextController,
                    validator: (value)=>value!.trim().isEmpty?'Please fill': null),
              
                  const SizedBox(height:50.0),
                  
                  CustomFormField(isEnable: action,
                    hint: "Insurance email",
                    controller: _emailTextController,
                    validator: (value)=>UiUtils.validateEmail(_emailTextController.text),
                  ),
                  
                  const SizedBox(height:50.0),
              
                  CustomFormField(isEnable: action,
                    hint: "Insurance Number",
                    controller: _insuranceNumberTextController,
                    validator: (value)=>value!.trim().isEmpty?'Please fill': null,
                  ),
          ],),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          "Insurer details",
          fontSize:15.0),
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
        actions: [
          TextButton(onPressed: () {
            if(action){
              // update user insurance details
              updateUserData();
            }else{
          setState(() {
            action=!action;
          });
            }
          },
          child: customText(
          action?'Done':'Edit',
          fontSize:15.0),),
        ],
      ),
      body:body(context),
    );
  }
  
  void updateUserData() {
    if(_formKey.currentState!.validate()){
     InsuranceDetail details =  InsuranceDetail(
      email: _emailTextController.text,
       insuranceCompany: _nameTextController.text,
        insuranceNumber: _insuranceNumberTextController.text,
         policyNumber: _policyNumberTextController.text);
    Users(userId: user.id).updateUserData('insuranceDetail', details.toJson());
    
          setState(() {
            action=!action;
          });
    }
  }
  

}