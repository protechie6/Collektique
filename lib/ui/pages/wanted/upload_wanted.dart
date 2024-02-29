import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/ui/pages/common/image_selection.dart';
import 'package:watch_vault/database_collection/wanted_database.dart';
import 'package:watch_vault/ui/widgets/brands.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/ui/widgets/year_picker.dart';

class UploadWanted extends StatefulWidget {
  const UploadWanted({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UploadWantedState();
}

class UploadWantedState extends State<UploadWanted> {
  final _formKey = GlobalKey<FormState>();

  //TextFormField values
  String _brand = "";
  String _model = "";
  String _year = "";
  String _boxAndPaper = "";
  List<String> images = List.empty(growable: true);
  String _serviceRecords = "";
  String _newOrOld = "";
  String _price = "";

  String? userId;

  UploadTask? uploadTask;

  bool uploading = false;

  // downloadUrls list lenght
  int addedUrl = 0;

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageSelection(images: images,)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
    setState(() => images.addAll(result));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = Provider.of<FirebaseUser?>(context);
    setState(() => userId = user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    
    Widget addImages = GestureDetector(
      onTap: () {
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
            Expanded(
              child: Text(
                "+ ${images.length}",
                style: const TextStyle(
                    color: Color.fromRGBO(32, 72, 72, 1),
                    fontFamily: 'Poppins',
                    fontSize: 32.0,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1 /*PERCENT not supported*/
                    ),
              ),
            ),
           const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Add",
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
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Watch images",
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
            ),
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
          child: WatchBrands(
            selectedBrand: (String value){
            if(value != "Watch brand"){
              setState(()=> _brand=value);
            }
          },
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
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _model = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter watch model" : null),
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
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _boxAndPaper = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter yes or no" : null),
          ),
        ),
      ]),
    );

    Widget serviceRecords = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Service Records: ",
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
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _serviceRecords = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter service records" : null),
          ),
        ),
      ]),
    );

    Widget newOrOldBox = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "New or Used: ",
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
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _newOrOld = value);
            },
            validator: ((value) => value!.trim().isEmpty ? "Required!" : null),
          ),
        ),
      ]),
    );

    Widget priceBox = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Price: ",
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
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _price = value);
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter yes or no" : null),
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
          if (_formKey.currentState!.validate()) {
            if (images.isEmpty) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('Add watch images')));
            } else {
              uploadImages();
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
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addImages,
                    productDetails,
                    brand,
                    model,
                    year,
                    boxAndPapers,
                    serviceRecords,
                    newOrOldBox,
                    priceBox,
                    saveButton,
                  ],
                ),
              ),
            ),
    );
  }

  void uploadImages() {
    List<String> downloadUrls = List.empty(growable: true);

    for (int i = 0; i < images.length; i++) {
      String filePath =
          "${userId!}/watchImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      final metadata = SettableMetadata(contentType: "image/jpeg");

      setState(() {
        uploadTask = storageRef.putFile(File(images[i]), metadata);
      });

      uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          // Handle successful uploads on complete
          String downloadUrl = await storageRef.getDownloadURL();
          downloadUrls.add(downloadUrl);
          setState(() => addedUrl = downloadUrls.length);
          setState(() {
              uploadTask = null;
            });
          if (downloadUrls.length == images.length) {
            
            WantedWatchDatabase()
                .insertWantedwatchData(_brand, _model, _year, downloadUrls,
                    userId!, _serviceRecords, _newOrOld, _price, _boxAndPaper)
                .whenComplete(() => Navigator.pop(context));
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
            final progress = 100.0 * (data!.bytesTransferred / data.totalBytes);
            return Text(
              '$progress',
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
        Text(
          "$addedUrl/${images.length}",
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20.0,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        const Text(
          "Uploading",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18.0,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        const LoadingDialog(),
        buildProgress(),
      ],
    );
  }
}
