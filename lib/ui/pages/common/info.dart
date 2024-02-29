import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';

class Info extends StatefulWidget{
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() =>AppDetailsState();
}

class AppDetailsState extends State<Info>{

  Widget body(){

    return Container(
      padding:const EdgeInsets.all(20.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                        fit: BoxFit.contain,
                        width: 250.0,
                        height: 250.0,
                ),
              ),
              const SizedBox(
          height:10.0,
              ),
              //about app
              customButton(
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicy(),
            ),
          );
        },
        elevation: 0,
        buttonWidth: 150.0,
        backgroundColor: AppColors.white,
        child: customText('Privacy Policy',
                fontSize: 18.0,
                textAlign: TextAlign.start,
                textColor: AppColors.textColor)
      ),

      const SizedBox(
          height:30.0,
              ),
              // terms and conditions
              customButton(
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditions(action: 'view'),
            ),
          );
        },
        elevation: 0,
        buttonWidth: 200.0,
        backgroundColor: AppColors.white,
        child: customText('Terms and Conditions',
                fontSize: 18.0,
                textAlign: TextAlign.start,
                textColor: AppColors.textColor)
      ),

      const SizedBox(
          height:30.0,
              ),

      // license
      customButton(
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LicensePage(),
            ),
          );
        },
        elevation: 0,
        buttonWidth: 150.0,
        backgroundColor: AppColors.white,
        child: customText('Licenses',
                fontSize: 18.0,
                textAlign: TextAlign.start,
                textColor: AppColors.textColor),
      ),
              const Spacer(),

              // footer
              Row(
                children: [
                  const Spacer(),
                  customText('Version: ',fontSize: 14.0,textAlign: TextAlign.start),
                  const SizedBox(height:5.0),
                  customText('1.0.1',fontSize: 12.0,textAlign: TextAlign.start),
                  const Spacer(),
                ],
              ),const SizedBox(
          height:20.0,
              ),
              Row(
                children: [
                  const Spacer(),
                  customText('Release date: ',fontSize: 14.0,textAlign: TextAlign.start),
                  const SizedBox(height:5.0),
                  customText('12.05.2023',fontSize: 12.0,textAlign: TextAlign.start),
                  const Spacer(),
                ],
              ),
            ]
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
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
        elevation: 0,
      ),
      body: body(),
    );
  }
}