import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/database_collection/stolen_database.dart';
import 'package:watch_vault/ui/widgets/brands.dart';
import 'package:watch_vault/ui/widgets/dialog.dart';
import 'package:watch_vault/ui/widgets/year_picker.dart';
import '../../../models/firebase_user.dart';
import '../../../models/my_library_model.dart';
import '../common/image_selection.dart';

class UploadStolenWatch extends StatefulWidget {
  const UploadStolenWatch({Key? key, this.data}) : super(key: key);

  final MyLibraryModel? data;

  @override
  State<UploadStolenWatch> createState() => _UploadStolenWatchState();
}

class _UploadStolenWatchState extends State<UploadStolenWatch> {

  final _formKey = GlobalKey<FormState>();

 final  ValueNotifier<String> _brand = ValueNotifier("");

  late TextEditingController modelController;

  late TextEditingController serialNumberController;

  late String _year;
  
  late List<String> images;

  final ValueNotifier<String> _dateStolen = ValueNotifier("");

  UploadTask? uploadTask;

  bool uploading = false;

  UserData? user;

  // downloadUrls list lenght
  int addedUrl = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    user = Provider.of<UserData>(context);
  }

  @override
  void initState(){

    modelController = TextEditingController(text:widget.data?.model);
    serialNumberController = TextEditingController(text: widget.data?.serialNumber);
    setState((){
      if(widget.data == null){
        images = List.empty(growable: true);
        _year = "";
              }else{
        images = widget.data!.images;
        _year = widget.data!.year;
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

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
    setState((){
      if(images.isNotEmpty){
        images.clear();
      }
      images.addAll(result);
    });
  }

  void reportStolen(downloadUrls){
    StolenWatchDatabase()
                .insertStolenWatchData(_brand.value, modelController.text, serialNumberController.text, _year,
                    _dateStolen.value, downloadUrls, user!.id)
                .whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {

    Widget selectDate = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ValueListenableBuilder<String>(
        builder: (BuildContext context, value, Widget? child) { 
          DateTime selectedDate = DateTime.now();
          return TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
      
            //if user clicked 'cancel' => null
            if (picked == null) return;
      
            // if user clicked 'OK' =>DateTime
            selectedDate = picked;
          _dateStolen.value = "${selectedDate.toLocal()}".split(' ')[0];

          },
          child: Text(value,
              style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColors.textColor,
                  fontFamily: 'Poppins')),
        );
        },
        valueListenable: _dateStolen,
      ),
    );

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
            const Spacer(),
            Text(
                "+ ${images.length}",
                style: const TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Poppins',
                    fontSize: 32.0,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1 /*PERCENT not supported*/
                    ),
              ),
              const SizedBox(height: 10.0),
                          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Add Watch images",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.bold,
                    height: 1 /*PERCENT not supported*/
                    ),
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
          child: ValueListenableBuilder(
            builder: (BuildContext context, value, Widget? child) {
              return WatchBrands(selectedBrand: (String value){
              if(value != "Watch brand"){
                _brand.value = value;
              }
            }, initialValue: widget.data?.brand,);
            },
            valueListenable: _brand,
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
            controller: modelController,
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
            controller: serialNumberController,
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
            validator: ((value) =>
                value!.trim().isEmpty ? "Enter a serial number" : null),
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
           },year: widget.data?.year)),
      ]),
    );

Widget userName = Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(children: [
                        const Text(
                          "User: ",
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
        enabled: false,
        style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.textColor,
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.red,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        initialValue: user!.username,
      )
                        ),
                      ]),
                    );

    Widget dateStolen = Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Row(children: [
        const Text(
          "Date stolen: ",
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
          child: selectDate,
        ),
      ]),
    );

    Widget save(String userId) {
      return Container(
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
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
                if(widget.data != null){
                  reportStolen(images);
                }
                uploadImages(userId);
                setState(() => uploading = true);
              }
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Stolen watch",
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
                    userName,
                    dateStolen,
                    save(user!.id),
                  ],
                ),
              ),
            ),
    );
  }

  void uploadImages(String userId) {
    List<String> downloadUrls = List.empty(growable: true);

    for (int i = 0; i < images.length; i++) {
      String filePath =
          "$userId/watchImages/${DateTime.now().millisecondsSinceEpoch}.jpg";

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
          if (downloadUrls.length == images.length) {
            setState(() {
              uploadTask = null;
            });
            reportStolen(downloadUrls);
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
        Text("$addedUrl/${images.length}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20.0,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.0,
            )),
        const LoadingDialog(),
        buildProgress(),
      ],
    );
  }
}
