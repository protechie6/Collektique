import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/sales_model.dart';
import 'package:watch_vault/ui/widgets/carousel.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import '../../../database_collection/library.dart';
import '../../../database_collection/sales_database.dart';
import '../../../models/firebase_user.dart';
import '../../widgets/text.dart';
import '../common/box_and_papers.dart';
import '../message/conversation.dart';

class SaleItemDetails extends StatefulWidget{
   const SaleItemDetails({Key? key, required this.itemDetails})
      : super(key: key);

  final SalesWatchModel itemDetails;
  
  @override
  State<SaleItemDetails> createState()=>SaleItemDetailsState();
}

class SaleItemDetailsState extends State<SaleItemDetails> {

BranchUniversalObject? buo;
  BranchLinkProperties? lp;
 FirebaseUser? user;
 ValueNotifier<bool> fav = ValueNotifier(false);

  @override
  void initState(){
    initializeDeepLinkData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<FirebaseUser?>(context);
    if(widget.itemDetails.likes.contains(user!.uid)){
      fav.value=true;
    }
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
      print('${response.errorCode} - ${response.errorMessage}');
    }
  }

  void saveItem(){
    LibraryDatabaseService(userId: user!.uid)
    .saveFromSales(widget.itemDetails).then((value){
      SalesDatabase().likeSalesItem(widget.itemDetails.id, user!.uid);
    });
  }

  void removeSavedItem(){
    LibraryDatabaseService(userId: user!.uid).removeSavedItem(widget.itemDetails.id).then((value){
      SalesDatabase().unlikeSaleItem(widget.itemDetails.id, user!.uid);
    });
  }
 
 @override
  Widget build(BuildContext context) {
    
    Widget viewsAndHeart(){
      return Container(
        margin: const EdgeInsets.only(
        left: 20,
        right: 20.0,
      ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: customText('0 views', fontSize: 15.0,),
            ),
            const Spacer(),
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, value, Widget? child) {
                return IconButton(
                icon: Icon(
                Icons.favorite,
                size: 18.0,
                color: value?Colors.red:Colors.white,
              ), 
              onPressed: () {
                if(value){
                  removeSavedItem();
                  fav.value=!fav.value;
                }else{
                  saveItem();
                  fav.value=!fav.value;
                }
              },);
              },
              valueListenable: fav,
              //child:null,
            ),
            const SizedBox(
              width:30.0,
            ),
            IconButton(
              icon: const Icon(
              Icons.share,
              size: 18.0,
              color: Colors.white,
            ), 
            onPressed: () { 
              _generateDeepLink();
             },),
          ],
        )
      );
    } 
    
    Widget textSection = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "${widget.itemDetails.brand} ${widget.itemDetails.model}",
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 20,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
      ),
      child: const Text(
        "Watch details:",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 18,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget brand = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Brand: ${widget.itemDetails.brand}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget model = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Model: ${widget.itemDetails.model}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget serialNumber = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Serial Number: ${widget.itemDetails.serialNumber.replaceRange(0, 4, '*' * 4)}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Year: ${widget.itemDetails.year}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 0,
        left: 20,
      ),
      child: Row(children: <Widget>[
        Text(
          "Box and Papers: ${widget.itemDetails.boxAndPapersList.length} image(s)",
          style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoxAndPapers(boxAndPapers: widget.itemDetails.boxAndPapersList, activity: 'Box and Papers',)),
            );
          },
          icon: const Icon(
            // <-- Icon
            Icons.image,
            size: 18.0,
            color: Colors.white,
          ),
        ),
      ]),
    );

    Widget insured = Container(
      margin: const EdgeInsets.only(
        top: 0,
        left: 20,
      ),
      child: Text(
        "Insured: ${widget.itemDetails.insured}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget serviceRecords = Container(
      margin: const EdgeInsets.only(
        top: 0,
        left: 20,
      ),
      child: Row(children: <Widget>[
        Text(
          "Service Records: ${widget.itemDetails.serviceRecords.length} image(s)",
          style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoxAndPapers(boxAndPapers: widget.itemDetails.serviceRecords, activity: 'Service Records',)),
            );
          },
          icon: const Icon(
            // <-- Icon
            Icons.image,
            size: 18.0,
            color: Colors.white,
          ),
        ),
      ]),
    );

    Widget ownedFor = Container(
      margin: const EdgeInsets.only(
        top: 0,
        left: 20,
      ),
      child: Text(
        "Owned For: ${widget.itemDetails.ownedFor}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
      ),
    );

    Widget price = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Text(
        "Price: ${widget.itemDetails.price}",
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0 /*PERCENT not supported*/
            ),
      ),
    );

    Widget contact = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "Contact Seller",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Conversation(listItem: widget.itemDetails.userId)),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale watch details",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            )),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textSection,
            Carousel(
              images: widget.itemDetails.images,
            ),
            viewsAndHeart(),
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            insured,
            serviceRecords,
            ownedFor,
            price,
            Visibility(
              visible: widget.itemDetails.userId != user!.uid ? true : false,
              child: contact),
          ],
        ),
      ),
    );
  }
}
