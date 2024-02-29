import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import '../../../utils/ui_utils.dart';

class ImageSelection extends StatefulWidget {
  const ImageSelection({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  List<String> imagePaths = List.empty(growable: true);
  UserData? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserData>(context);
  }

  @override
  void initState() {
    super.initState();
    imagePaths.addAll(widget.images);
  }

  Future getImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() => imagePaths.add(image.path));
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Widget addImage = Container(
      width: (double.infinity),
      margin: const EdgeInsets.only(
        left: 35.0,
        right: 35.0,
        bottom: 20.0,
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
          "Done",
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
          if(user!.accountType==AppConstants.basic && imagePaths.length>5){
      UiUtils.upgradeAccountDialog(context);
    }
    else if(user!.accountType==AppConstants.pro && imagePaths.length >15){
      UiUtils.upgradeAccountDialog(context);
    }else if(user!.accountType==AppConstants.platinum && imagePaths.length>30){
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Can't upload more than 30")));
    }
    else{
      Navigator.pop(context, imagePaths);
    }
        },
      ),
    );

    return WillPopScope(
      onWillPop: () async{ 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('USE THE "DONE" BUTTON'),
            backgroundColor: AppColors.backgroundColor,
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Add images",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 15,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          centerTitle: true,
          leading: const SizedBox(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18.0,
              ),
              onPressed: () {
                getImage(ImageSource.camera);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_photo_alternate_rounded,
                color: Colors.white,
                size: 18.0,
              ),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: imagePaths.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          child: imagePaths[index].contains("http")? CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        imageUrl: imagePaths[index],
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ):Image.file(
                            File(imagePaths[index]),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              // remove image
                              setState(() {
                                imagePaths.remove(imagePaths[index]);
                              });
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 24.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              addImage,
            ],
          ),
        ),
      ),
    );
  }
}
