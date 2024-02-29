import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/library.dart';
import 'package:watch_vault/database_collection/sales_database.dart';
import 'package:watch_vault/ui/widgets/brands.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/ui/widgets/toggle_switch.dart';
import 'package:watch_vault/ui/widgets/year_picker.dart';
import '../../../widgets/currencies.dart';
import '../../../widgets/text.dart';
import '../../common/image_selection.dart';

class UploadWatch extends StatefulWidget {
  const UploadWatch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UploadWatchState();
}

class UploadWatchState extends State<UploadWatch> {

  final _formKey = GlobalKey<FormState>();

  //TextFormField values
  String _brand = "";
  String _model = "";
  String _serialNumber = "";
  String _year = "";
  String _insured = "";
  final ValueNotifier<List<String>> _boxAndPaper =
      ValueNotifier(List.empty(growable: true));
  final ValueNotifier<List<String>> _serviceRecords =
      ValueNotifier(List.empty(growable: true));
  final ValueNotifier<List<String>> images =
      ValueNotifier(List.empty(growable: true));
  final ValueNotifier<String> imageSelection = ValueNotifier("");
  //ValueNotifier<String> currency = ValueNotifier("EUR");
  late TextEditingController priceController;
  String _ownedFor = "";
  String _forSale = "";
  String _price = "";
  String title = "";

  List<String> currentList = List.empty(growable: true);

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

    switch (imageSelection.value) {
      case "boxAndPapers":
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageSelection(
                      images: _boxAndPaper.value,
                    )));

        // When a BuildContext is used from a StatefulWidget, the mounted property
        // must be checked after an asynchronous gap.
        if (!mounted) return;
        if (_boxAndPaper.value.isNotEmpty) {
          _boxAndPaper.value.clear();
        }
        _boxAndPaper.value = result;
        break;

      case "serviceRecords":
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageSelection(
                      images: _serviceRecords.value,
                    )));

        // When a BuildContext is used from a StatefulWidget, the mounted property
        // must be checked after an asynchronous gap.
        if (!mounted) return;
        if (_serviceRecords.value.isNotEmpty) {
          _serviceRecords.value.clear();
        }
        _serviceRecords.value = result;
        break;

      default:
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageSelection(
                      images: images.value,
                    )));

        // When a BuildContext is used from a StatefulWidget, the mounted property
        // must be checked after an asynchronous gap.
        if (!mounted) return;
        if (images.value.isNotEmpty) {
          images.value.clear();
        }
        images.value = result;
        break;
    }
  }

  @override
  void initState(){
    String initialValue = NumberFormat.simpleCurrency(name:'EUR', decimalDigits: 2).format(0);
    priceController = TextEditingController(text: initialValue);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<FirebaseUser?>(context);
  }

  @override
  void dispose() {
    _boxAndPaper.dispose();
    images.dispose();
    imageSelection.dispose();
    _serviceRecords.dispose();

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
                valueListenable: images,
                builder: (context, value, child) {
                  return customText(
                    "+ ${images.value.length}",
                        fontSize: 32.0,
                        textColor:AppColors.textColor,
                  );
                }),
            const SizedBox(
              height: 10.0,
            ),
            customText(
              " Add watch images",
                  fontSize: 18,
                  textColor: AppColors.textColor,
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
      child: customText(
        "Watch details:",
            fontSize: 18,
      ),
    );

    Widget brand = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
         customText(
          "Brand: ",
              fontSize: 15,
        ),
        Expanded(
          child: WatchBrands(
            selectedBrand: (String value) {
              if (value != "Watch brand") {
                setState(() => _brand = value);
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
            style: textStyle(
                fontSize: 14.0,
                color: const Color.fromRGBO(32, 72, 72, 1),),
            decoration: InputDecoration(
              hintText: "Add details",
              hintStyle: textStyle(
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() => _serialNumber = value);
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
          child: SelectYearDialog(
            selectedYear: (String value) {
              setState(() => _year = value);
            },
          ),
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
              builder: (context, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                  onPressed: () {
                    imageSelection.value = "boxAndPapers";
                    _navigateAndDisplaySelection(context);
                  },
                  child: Row(children: [
                    ValueListenableBuilder<List<String>>(
                      valueListenable: _boxAndPaper,
                      builder: (context, value, child) {
                        return Text(
                          value.isEmpty
                              ? "Add details"
                              : "${value.length} image(s)",
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
                      },
                    ), // <-- Text
                    const Spacer(),
                    const Icon(
                      // <-- Icon
                      Icons.image,
                      size: 18.0,
                      color: AppColors.buttonColor1,
                    ),
                  ]),
                );
              }),
        ),
      ]),
    );

    Widget insured = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Insured: ",
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
          child: TextSwitchToggle(
            selected: (String value) {
              setState(() => _insured = value);
            },
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
          child: ValueListenableBuilder<String>(
              valueListenable: imageSelection,
              builder: (context, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                  onPressed: () {
                    imageSelection.value = "serviceRecords";
                    _navigateAndDisplaySelection(context);
                  },
                  child: Row(children: [
                    ValueListenableBuilder<List<String>>(
                      valueListenable: _serviceRecords,
                      builder: (context, value, child) {
                        return Text(
                          value.isEmpty
                              ? "Add details"
                              : " ${value.length} image(s)",
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
                      },
                    ), // <-- Text
                    const Spacer(),
                    const Icon(
                      // <-- Icon
                      Icons.image,
                      size: 18.0,
                      color: AppColors.buttonColor1,
                    ),
                  ]),
                );
              }),
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
                color: Color.fromRGBO(32, 72, 72, 1),
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
              setState(() => _ownedFor = value);
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
         customText(
          "Value: ",
          fontSize: 15,
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller:priceController,
            style: textStyle(fontSize: 14.0,color:AppColors.textColor),
            decoration: InputDecoration(
              hintText: "Add details",
              hintStyle: textStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              filled: true,
              fillColor: Colors.white,
            ),onChanged: (value){
              setState((){
                _price=value;
              });
            },
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter watch Value" : null),
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
            if (_brand == "") {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('Select watch brand')));
            } else if (images.value.isEmpty) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('Add watch images')));
            } else {
              uploadServiceRecordImages();
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
                    serialNumber,
                    year,
                    boxAndPapers,
                    insured,
                    serviceRecords,
                    ownedFor,
                    forSale,
                    price,
                    Currency(selectedCurrency: (String value) {
                      int x = int.parse((priceController.text).replaceAll(RegExp('[^0-9]'), ''));
                      priceController.clear();
                       String initialValue = NumberFormat.simpleCurrency(name:value, decimalDigits: 2).format(x);
                       setState((){
                        priceController = TextEditingController(text: initialValue);
                       });
                    },),
                    saveButton,
                  ],
                ),
              ),
            ),
    );
  }

  void uploadImages(List<String> serviceRecords, List<String> boxAndPapers){
    
    List<String> downloadUrls = List.empty(growable: true);

    for (int i = 0; i < images.value.length; i++) {
      String filePath =
          "${user!.uid}/watchImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

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
          setState(() => addedUrl = downloadUrls.length);
          if (downloadUrls.length == images.value.length) {
            setState(() {
              uploadTask = null;
            });
            if (_forSale == "Yes") {
              SalesDatabase().insertSalewatchData(
                  _brand,
                  _model,
                  _serialNumber,
                  _year,
                  _insured,
                  serviceRecords,
                  _ownedFor,
                  _price,
                  user!.uid,
                  boxAndPapers,
                  downloadUrls);
            }
            LibraryDatabaseService(userId: user!.uid)
                .insertLibraryData(
                    _brand,
                    _model,
                    _year,
                    _serialNumber,
                    downloadUrls,
                    boxAndPapers,
                    _insured,
                    serviceRecords,
                    _ownedFor,
                    _forSale,
                    AppConstants.watch,
                    "",
                    "",
                    "",
                    "",
                    "",
                    _price)
                .whenComplete(() => Navigator.pop(context));
          }
        }
      });
    }
  }

  void uploadServiceRecordImages() {
    if (_serviceRecords.value.isNotEmpty) {
      List<String> downloadUrls = List.empty(growable: true);

      for (int i = 0; i < _serviceRecords.value.length; i++) {
        String filePath =
            "${user!.uid}/itemImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

        final storageRef = FirebaseStorage.instance.ref().child(filePath);

        final metadata = SettableMetadata(contentType: "image/jpeg");

        setState(() {
          uploadTask =
              storageRef.putFile(File(_serviceRecords.value[i]), metadata);
              title = "Service Records";
        noOfItems=_serviceRecords.value.length;
        });

        uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
          if (taskSnapshot.state == TaskState.success) {
            // Handle successful uploads on complete
            String downloadUrl = await storageRef.getDownloadURL();
            downloadUrls.add(downloadUrl);
            setState(() => addedUrl = downloadUrls.length);
            if (downloadUrls.length == _serviceRecords.value.length) {
              setState(() {
                uploadTask = null;
                noOfItems = 0;
              });
              uploadBoxAndPaperImages(downloadUrls);
            }
          }
        });
      }
    } else {
      uploadBoxAndPaperImages(_serviceRecords.value);
    }
  }

  void uploadBoxAndPaperImages(List<String> serviceRecords) {
    if (_boxAndPaper.value.isNotEmpty) {
      List<String> downloadUrls = List.empty(growable: true);

      for (int i = 0; i < _boxAndPaper.value.length; i++) {
        String filePath =
            "${user!.uid}/itemImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

        final storageRef = FirebaseStorage.instance.ref().child(filePath);

        final metadata = SettableMetadata(contentType: "image/jpeg");

        setState(() {
          uploadTask =
              storageRef.putFile(File(_boxAndPaper.value[i]), metadata);
              title = "Box and Papers";
        noOfItems=_boxAndPaper.value.length;
        });

        uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
          if (taskSnapshot.state == TaskState.success) {
            // Handle successful uploads on complete
            String downloadUrl = await storageRef.getDownloadURL();
            downloadUrls.add(downloadUrl);
            setState(() => addedUrl = downloadUrls.length);
            if (downloadUrls.length == _boxAndPaper.value.length) {
              setState(() {
                uploadTask = null;
                noOfItems = 0;
              });
              uploadImages(serviceRecords, downloadUrls);
            }
          }
        });
      }
    } else {
      uploadImages(_serviceRecords.value, _boxAndPaper.value);
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
        Text(
          "$addedUrl/$noOfItems",
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
         Text(
          "Uploading $title",
          style: const TextStyle(
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
