import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_vault/models/my_library_model.dart';
import '../../../models/firebase_user.dart';
import '../../../utils/all_constants.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/ui_utils.dart';
import '../../widgets/button.dart';
import '../../widgets/dialog.dart';
import '../../widgets/text.dart';
import '../stolen/upload_stolen_watch.dart';

class ReportStolenWatch extends StatelessWidget{
  final MyLibraryModel details;
  const ReportStolenWatch({Key? key, required this.details}) : super(key: key);

Future<void> sendMailToInsurance(BuildContext context, String insurerEmail) async {
  AppUtils.openDocument(details, '${details.brand} ${details.model}.pdf', details.images[0],insurerEmail,context);
}

void uploadToStolenDirectory(BuildContext context){
  if(details.type != AppConstants.watch){
            UiUtils.customSnackBar(context, msg: 'Not available for this item type.');
          }else{
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return UploadStolenWatch(data: details,);
          }));
          }
}

Widget body(BuildContext context){

  return Center(
    child: ValueListenableBuilder<bool>(
      
      valueListenable: AppUtils.isLoading,
      builder:(context, value, child){
        return value?const LoadingDialog():
        Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
      
          customText("${details.brand} ${details.model}",fontSize: 18.0),
          // upload to stolen directory
          customButton(
            backgroundColor: AppColors.white,
            function: () {
              uploadToStolenDirectory(context);
            }, child: customText("Upload to stolen directory",fontSize:15.0, textColor: AppColors.backgroundColor, fontWeight: FontWeight.bold)),
      
          customButton(
            backgroundColor: AppColors.white,
            function: () {
            final user = Provider.of<UserData>(context, listen: false);
            InsuranceDetail detail = InsuranceDetail.fromJson(user.insuranceDetail);
            if(detail.email==""){
              UiUtils.customSnackBar(context, msg: 'Cannot complete this action. \n Go to "ACCOUNT-Insurance details" to fill out the details.');
            }else{
            sendMailToInsurance(context,detail.email);
            }
            }, child: customText("Email to your insurance company",fontSize:15.0, textColor: AppColors.backgroundColor, fontWeight: FontWeight.bold)),
      
            customButton(
              backgroundColor: AppColors.white,
            function: () async{
            ////TODO CHECK IF INSURANCE COMPANY DETAILS HAS BEEN FILLED AND SAVED
            final Uri url = Uri(
              scheme: 'tel',
              path:'+1 012345678' 
            );
            if(await canLaunchUrl(url)){
    
            await launchUrl(url);
            }else{
              // ignore: use_build_context_synchronously
              UiUtils.customSnackBar(context, msg: 'Failed');
            }
            }, child: customText("Call insurance company",fontSize:15.0, textColor: AppColors.backgroundColor, fontWeight: FontWeight.bold)),
      
            customButton(
              backgroundColor: AppColors.white,
            function: () {
            ////TODO remove from stolen directory.
            
            }, child: customText("Stolen watch recovered",fontSize:15.0, textColor: AppColors.backgroundColor, fontWeight: FontWeight.bold)),
        ]
      );
      },
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          "Report stolen",
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
      ),
      body:body(context),
    );
  }
}