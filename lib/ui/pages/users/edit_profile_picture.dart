import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({Key? key,}) : super(key: key);
  @override
  State<EditProfilePicture> createState() => EditProfilePictureState();
}

class EditProfilePictureState extends State<EditProfilePicture> {
  File? imageView;

  bool isVisible = false;

  UploadTask? uploadTask;

  late UserData user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserData>(context);
  }

  Future pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => imageView = imageTemp);
    } on PlatformException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.code),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
      );
    }
  }

  uploadImage() {
    setState(() => isVisible = true);

    String filePath = "${user.id}/profilePicture/dp.jpg";

    final storageRef = FirebaseStorage.instance.ref().child(filePath);

    final metadata = SettableMetadata(contentType: "image/jpeg");

    setState(() {
      uploadTask = storageRef.putFile(imageView!, metadata);
    });

    uploadTask!.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          /*setState(() {
            inVisible = true;
          });*/
          break;
        case TaskState.paused:
          setState(() {
            isVisible = false;
          });
          break;
        case TaskState.canceled:
          setState(() {
            isVisible = false;
          });
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          setState(() {
            isVisible = false;
            uploadTask = null;
          });
          String downloadUrl = await storageRef.getDownloadURL();
          Users(userId: user.id)
              .updateUserData("dp", downloadUrl).whenComplete(() => Navigator.pop(context));

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    final double imageHeight = screenHeight / 2.0;

    Widget image = SizedBox(
        height: imageHeight,
        child: imageView == null
            ? Container(
                child: user.dp == "default"
                    ? const Icon(
                        Icons.image,
                        size: 150.0,
                        color: Colors.grey,
                      )
                    : CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        imageUrl: user.dp,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              )
            : Image.file(
                imageView!,
                fit: BoxFit.cover,
              ));

    Widget selectImageButton = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          foregroundColor: Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(150, 40), //////// HERE
        ),
        child: const Text("Select Image",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () {
          pickImage();
        },
      ),
    );

    Widget uploadButton = Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor1,
          foregroundColor: Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 50), //////// HERE
        ),
        child: const Text("Save",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () => uploadImage(),
      ),
    );

    Widget buildProgress() => StreamBuilder<TaskSnapshot>(
          stream: uploadTask?.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              final progress =
                   (data!.bytesTransferred / data.totalBytes);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      semanticsLabel: 'Uploading',
                      color: const Color.fromRGBO(32, 72, 72, 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${(progress * 100).toStringAsFixed(1)} %',
                        style: const TextStyle(
                          color: Color.fromRGBO(32, 72, 72, 1),
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text(
                'uploading...',
                style: TextStyle(
                  color: Color.fromRGBO(32, 72, 72, 1),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit profile picture",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: "Poppins",
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 5.0,
          right: 5.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            image,
            selectImageButton,
            Visibility(
              visible: isVisible,
              child: buildProgress(),
            ),
            uploadButton,
          ],
        ),
      ),
    );
  }
}
