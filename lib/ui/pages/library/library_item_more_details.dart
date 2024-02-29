import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:share_plus/share_plus.dart';
import '../../../models/my_library_model.dart';
import '../../../utils/all_constants.dart';
import '../../../utils/ui_utils.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';
import '../common/box_and_papers.dart';
import '../transaction/transfer_or_share.dart';
import 'edit_item/public_or_private.dart';
import 'edit_item/upload_my_library_2.dart';
import 'report_stolen._watch.dart';

class LibraryItemMoreDetails extends StatefulWidget {
  const LibraryItemMoreDetails({Key? key, required this.details})
      : super(key: key);
  final MyLibraryModel details;

  @override
  State<LibraryItemMoreDetails> createState() => LibraryItemMoreDetailsState();
}

class LibraryItemMoreDetailsState extends State<LibraryItemMoreDetails> {
  BranchUniversalObject? buo;
  BranchLinkProperties? lp;

  @override
  void initState() {
    initializeDeepLinkData();
    super.initState();
  }

//To Setup Data For Generation Of Deep Link
  void initializeDeepLinkData() {
    buo = BranchUniversalObject(
      canonicalIdentifier: AppConstants.branchIoCanonicalIdentifier,
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata(
            AppConstants.deepLinkTitle, AppConstants.deepLinkData),
    );
    FlutterBranchSdk.registerView(buo: buo!);

    lp = BranchLinkProperties();
    lp!.addControlParam(AppConstants.controlParamsKey, '1');
  }

  //To Generate Deep Link For Branch Io
  void _generateDeepLink() async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp!);
    if (response.success) {
      await Share.share("Check this out! ${response.result}");
    } else {
      // ignore: use_build_context_synchronously
      UiUtils.customSnackBar(context, msg: '${response.errorCode} - ${response.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget upload = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: Colors.white,
        child: customText("Upload",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadII(
                      details: widget.details,
                    )),
          );
        },
      ),
    );

    Widget serviceRecordImage = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: AppColors.white,
        child: customText("Service Record Image\n & \n Box and Papers",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BoxAndPapers(
                      boxAndPapers: widget.details.boxAndPapers, activity: 'true',
                    )),
          );
        },
      ),
    );

    Widget shareWithMember = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: AppColors.white,
        child: customText("Share with member",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransferOrShare(
                      routeTitle: "Share with member",
                      details: widget.details,
                    )),
          );
        },
      ),
    );

    Widget shareToFriends() {
      return customButton(
          function: () {
             _generateDeepLink();
          },
          backgroundColor: AppColors.white,
          child: customText('Share with friends',
              fontSize: 15.0,
              textColor: AppColors.backgroundColor,
              fontWeight: FontWeight.bold));
    }

    Widget transferToMember = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: AppColors.white,
        child: customText("Transfer to a member",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransferOrShare(
                      routeTitle: "Transfer to member",
                      details: widget.details,
                    )),
          );
        },
      ),
    );

    Widget publicOrPrivate = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: AppColors.white,
        child: customText("Private or public",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicOrPrivate(
                      details: widget.details,
                    )),
          );
        },
      ),
    );

    Widget stolen = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: customButton(
        backgroundColor: AppColors.white,
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportStolenWatch(
                      details: widget.details,
                    )),
          );
        },
        child: customText("Report Stolen",
            fontSize: 15.0,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      appBar: AppBar(
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
        elevation: 0,
      ),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // username
            customText(
              "${widget.details.brand} ${widget.details.model}",
              fontSize: 18.0,
            ),
            upload,
            serviceRecordImage,
            shareWithMember,
            shareToFriends(),
            transferToMember,
            publicOrPrivate,
            stolen,
          ],
        ),
      ),
    );
  }
}
