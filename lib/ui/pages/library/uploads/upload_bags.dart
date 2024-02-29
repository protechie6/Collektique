import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/library.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/ui/widgets/item_condition.dart';
import 'package:watch_vault/ui/widgets/toggle_switch.dart';
import 'package:watch_vault/ui/widgets/year_picker.dart';

import '../../../widgets/text.dart';
import '../../common/image_selection.dart';

class UploadBag extends StatefulWidget{
  const UploadBag({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => UploadBagState();

}

class UploadBagState extends State<UploadBag> {

  final  _formKey =  GlobalKey<FormState>();

  //TextFormField values
  String _brand = "";
  String _model = "";
  String _serialNumber = "";
  String _year = "";
  String title = "";
  final ValueNotifier<List<String>> _boxAndPaper = ValueNotifier(List.empty(growable: true));
  final ValueNotifier<List<String>> images = ValueNotifier(List.empty(growable: true));
  String _bagSize = "";
  final ValueNotifier<String> _condition = ValueNotifier("");
  String _ownedFor = "";
  String _forSale = "";
  String _price = "";
  final ValueNotifier<String> imageSelection = ValueNotifier("");

  FirebaseUser? user;

  UploadTask? uploadTask;

  bool uploading = false;

  // downloadUrls list lenght
  int addedUrl = 0;

  // no of items
  int noOfItems = 0;

    // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    if(imageSelection.value == "boxAndPapers"){
      final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageSelection(images:_boxAndPaper.value,)));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
      if(_boxAndPaper.value.isNotEmpty){
        _boxAndPaper.value.clear();
      }
      _boxAndPaper.value=result;
    }
    else{
      final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageSelection(images:images.value,)));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
  if(images.value.isNotEmpty){
        images.value.clear();
      }
      images.value=result;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<FirebaseUser?>(context);
  }

  @override
  void dispose() {

    _condition.dispose();
    _boxAndPaper.dispose();
    images.dispose();
    imageSelection.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

  
    Widget addImages = GestureDetector(
      onTap: () {
        imageSelection.value = "itemImages";
        _navigateAndDisplaySelection(context);
      },
      child: Container(
        width: double.infinity,
        height: 150.0,
        margin: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            const Spacer(),
            ValueListenableBuilder<List<String>>(
                valueListenable:images,
                builder: (context, value, child){
                  return Text(
                  "+ ${value.length}",
                  style: const TextStyle(
                      color: Color.fromRGBO(32, 72, 72, 1),
                      fontFamily: 'Poppins',
                      fontSize: 32.0,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1 /*PERCENT not supported*/
                      ),
                );
                } ,
              ),
             const SizedBox(
              height: 10.0,
            ),const Text(
                "Add bag images",
                style: TextStyle(
                    color: Color.fromRGBO(32, 72, 72, 1),
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1 /*PERCENT not supported*/
                    ),
              ),
              const Spacer(),
          ]),
        ),
      ),
    );

    Widget productDetails = Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20,
      ),
      child: const Text(
        "Bag details:",
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
        right: 20,
      ),
      child: Row(children: [
         const Text(
          "Brand: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_brand = value);
            }
          ,
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter bag brand" : null),
          ),
        ),
      ]),
    );

    Widget model = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Model: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_model = value);
            }
          ,
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter bag model" : null),
          ),
        ),
      ]),
    );

    Widget serialNumber = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Serial Number: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            maxLength: 15,
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_serialNumber = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter serial number" : null),
          ),
        ),
      ]),
    );

    Widget year = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Year: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: SelectYearDialog(selectedYear: (String value) { 
            setState(()=>_year = value);
           },),
        ),
      ]),
    );

    Widget boxAndPapers = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Box and paper: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable: imageSelection,
            builder:(context, value, child){
              return  ElevatedButton(
              style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            minimumSize: const Size(double.infinity, 50.0),
                  ),
              onPressed: () {
                imageSelection.value = "boxAndPapers";
                _navigateAndDisplaySelection(context);
              },
            child: Row(
              children:[
              ValueListenableBuilder<List<String>>(
                valueListenable:_boxAndPaper,
                builder:(context, value, child){
                  return Text(value.isEmpty?
                  "Add details": "${value.length} image(s)",
                  style: const TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.5 /*PERCENT not supported*/
                      ),
                );
                } ,
              ), // <-- Text
              const Spacer(),
              const Icon(
                // <-- Icon
                Icons.image,
                size: 18.0,
                color: AppColors.buttonColor1,
              ),
              ]
            ),
            );
            }
          ),
        ),
      ]),
    );
    
    Widget bagSize = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Bag size: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_bagSize = value);
            }
          ,
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter bag size" : null),
          ),
        ),
      ]),
    );

    Widget condition = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Condition: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable:_condition,
            builder: (context, value, child){
              return ItemCondition(
                selectedConditon: (String value) {
                  _condition.value = value;
            },);
            }
          ),
        ),
      ]),
    );

    Widget ownedFor = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Owned For: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details, eg: 5 years",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_ownedFor = value);
            },
          ),
        ),
      ]),
    );

    Widget forSale = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        customText(
          "For Sale: ",
              fontSize: 15,
        ),
        Expanded(
          child: TextSwitchToggle(
            selected: (String value) {
              setState(() => _forSale = value);
            },
          ),
        ),
      ]),
    );

Widget price = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Value: ",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0 /*PERCENT not supported*/
              ),
        ),
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColor,
                fontFamily: 'Poppins'),
            decoration: const InputDecoration(
              hintText: "Add details",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(()=>_price = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter bag Value" : null),
          ),
        ),
      ]),
    );

    Widget saveButton = Container(
      width: (double.infinity),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: const Text(
          "Save",
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
          if(_formKey.currentState!.validate()){
            if(_brand==""){
              ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Select watch brand')));
            }
            else if(images.value.isEmpty){
              ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Add bag images')));
            }else{
              if(_boxAndPaper.value.isNotEmpty){
                uploadBoxAndPaperImages();
              }else{
                uploadImages(_boxAndPaper.value);
              }
            setState(() => uploading = true);
            }
          }
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload",
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
      body: uploading
          ? showUploadProgress()
          :SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addImages,
            productDetails,
            brand,
            model,
            serialNumber,
            year,
            boxAndPapers,
            bagSize,
            condition,
            ownedFor,
            forSale,
            price,
            saveButton,
          ],
        ),
        ),
      ),
    );
  }

  void uploadImages(List<String> boxAndPapers){

    List<String> downloadUrls = List.empty(growable: true);

    for (int i = 0; i < images.value.length; i++) {
      String filePath =
          "${user!.uid}/itemImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      final metadata = SettableMetadata(contentType: "image/jpeg");

      setState(() {
        uploadTask = storageRef.putFile(File(images.value[i]), metadata);
        title = "Images";
        noOfItems=images.value.length;
      });

      uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          // Handle successful uploads on complete
          String downloadUrl = await storageRef.getDownloadURL();
          downloadUrls.add(downloadUrl);
          setState(()=>addedUrl = downloadUrls.length); 
          if (downloadUrls.length == images.value.length) {
            setState(() {
              uploadTask = null;
            });
            /*if(_forSale == "Yes"){
              SalesDatabase().insertSalewatchData(_brand, _model, _serialNumber, _year, '${_boxAndPaper.value.length}', 
             _bagSize, _condition.value, _ownedFor, _price, userId!, boxAndPapers, downloadUrls);
            }*/
             LibraryDatabaseService(userId: user!.uid).insertLibraryData(_brand, _model, _year, _serialNumber, downloadUrls,
             boxAndPapers, "",[], _ownedFor, _forSale,AppConstants.bag,_bagSize,"","","",_condition.value, _price)
             .whenComplete(() => Navigator.pop(context));
          }
        }
      });
    }
  }

void uploadBoxAndPaperImages() {

    List<String> downloadUrls = List.empty(growable: true);

    for (int i = 0; i < _boxAndPaper.value.length; i++) {
      String filePath =
          "${user!.uid}/itemImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      final metadata = SettableMetadata(contentType: "image/jpeg");

      setState(() {
        uploadTask = storageRef.putFile(File(_boxAndPaper.value[i]), metadata);
        title = "Box and Papers";
        noOfItems=_boxAndPaper.value.length;
      });

      uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          // Handle successful uploads on complete
          String downloadUrl = await storageRef.getDownloadURL();
          downloadUrls.add(downloadUrl);
          setState(()=>addedUrl = downloadUrls.length); 
          if (downloadUrls.length == _boxAndPaper.value.length) {
            setState(() {
              uploadTask = null;
              noOfItems = 0;
            });
            uploadImages(downloadUrls);
          }
        }
      });
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            final progress = (data!.bytesTransferred / data.totalBytes);
            return Text(
              '${(progress * 100).toStringAsFixed(1)} %',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.0,
              ),
            );
          } else {
            return const Text(
              'uploading...',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.0,
              ),
            );
          }
        },
      );

      Widget showUploadProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Text("$addedUrl/$noOfItems",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20.0,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            ),),
            Text("Uploading $title",
            style:  const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 18.0,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            ),),
        const LoadingDialog(),
        buildProgress(),
      ],
    );
  }
}
