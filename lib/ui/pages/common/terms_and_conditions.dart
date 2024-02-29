import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';

class TermsAndConditions extends StatelessWidget{
 
  const TermsAndConditions({Key? key, required this.action}) : super(key: key);

  final String action;

  Widget body(BuildContext context){

    return Container(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText('Welcome to ${AppConstants.appName}\'s terms of service! By using our services, you agree to the following terms and conditions:',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Use of Service: ', textSpan1: 'You agree to use our services for lawful purposes only and in compliance with all applicable laws and regulations.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Data Privacy: ', textSpan1: 'We will handle your personal information in accordance with our Privacy Policy, which outlines how we collect, use, and protect your data.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Intellectual Property: ', textSpan1: 'You agree to use our services for lawful purposes only and in compliance with all applicable laws and regulations.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Payment Terms: ', textSpan1: 'You are responsible for paying any applicable fees and charges associated with the use of our services, as outlined in our payment terms and agreements.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Termination: ', textSpan1: 'We may terminate or suspend your access to our services at any time for any reason, including violation of our terms of service.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(top:10.0),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            const SizedBox(
              width: 10,
            ),
                Expanded(
                  child: bulletin(textSpan0: 'Limited Liability: ', textSpan1: 'We are not liable for any direct, indirect, incidental, or consequential damages resulting from the use or inability to use our services.'),
                ),
              ],
            ),
            const SizedBox(height:20.0),

            customText('By using our services, you agree to these terms and conditions. If you have any questions or concerns, please do not hesitate to contact us.',
            fontSize:16.0, textAlign: TextAlign.start),
           const SizedBox(height:20.0),

            Visibility(
              visible: action=='registration'?true:false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                customButton(
                  buttonWidth:150.0,
                  function: () { 
                  Navigator.pop(context,'I disagree');
                }, child:customText('I disagree', fontSize: 16.0, textColor: AppColors.white)),
                customButton(
                  buttonWidth:150.0,
                  function: () {
                    Navigator.pop(context, 'I agree');
                  }, child:customText('I agree', fontSize: 16.0, textColor: AppColors.white)),
              ],),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 24.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title:customText('Terms of Service', fontSize: 20.0,textColor: AppColors.white),
        elevation: 0,
      ),
      body: body(context),
    );
  }

}