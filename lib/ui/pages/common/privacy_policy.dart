import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import '../../widgets/text.dart';

class PrivacyPolicy extends StatelessWidget{
  const PrivacyPolicy({Key? key}) : super(key: key);

  Widget body(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText('1.	We at ${AppConstants.appName} are committed to protecting your privacy and ensuring the security of your personal information. This privacy policy explains how we collect, use, and safeguard your data when you visit our website or interact with our services.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('2. We collect personal information such as your name, email address, and demographic data when you voluntarily provide it to us. This information is used to personalize your experience, process your orders, and communicate with you about our products and services.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('3.	When you visit ${AppConstants.appName}, our servers automatically collect certain information about your device and browsing activities. This includes your IP address, browser type, referring/exit pages, and operating system. We analyze this data to improve our website\'s functionality, enhance user experience, and optimize our marketing efforts.',
            fontSize:16.0,textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('4. We may use cookies, web beacons, and similar tracking technologies to track your activity on our website. These technologies help us gather information about your preferences, monitor how you navigate our site, and provide personalized content and advertisements. You have the option to disable cookies but please note that certain features may not function properly without them.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('5. ${AppConstants.appName} may share your personal information with trusted third parties who assist us in conducting business operations, providing customer support, and delivering products and services to you. These partners are obligated to maintain the confidentiality and security of your information.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('6. We may disclose your personal information if required by law, or if we believe that such action is necessary to comply with a legal obligation, protect our rights or property, or prevent any potential harm to you or others.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('7. ${AppConstants.appName} takes appropriate measures to protect your personal information from unauthorized access, alteration, or destruction. We use industry-standard security practices, regularly monitor our systems for vulnerabilities, and maintain strict access controls to ensure the confidentiality of your data.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:10.0),

            customText('8. This privacy policy applies solely to information collected by Collektique\'s website/App and services. It does not apply to any external websites or services linked to our site. We encourage you to review the privacy policies of those third-party entities before disclosing any personal information.',
            fontSize:16.0, textAlign: TextAlign.start),
            const SizedBox(height:30.0),

            customText('If you have any questions, concerns, or requests regarding your privacy and the security of your data, please reach out to us using the contact details provided on our website. We are committed to addressing any issues promptly and ensuring that your experience with ${AppConstants.appName} is secure and enjoyable.',
            fontSize: 16.0, textAlign: TextAlign.start)
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
        title:customText('Privacy policy', fontSize: 20.0,),
        elevation: 0,
      ),
      body: body(context),
    );
  }

}