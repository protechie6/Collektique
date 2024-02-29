import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/my_library_model.dart';

class ImageSelection2 extends StatefulWidget {

  const ImageSelection2({Key? key, required this.details}) : super(key: key);

  final MyLibraryModel details;

  @override
  State<ImageSelection2> createState() => _ImageSelectionState2();

}

class _ImageSelectionState2 extends State<ImageSelection2> {
// local images
  List<String> addedImages = List.empty(growable:true);

  // internet images
  List<String> savedImages = List.empty(growable:true);

  // if internet images are selected
  bool isSelected = false;

  @override
  void initState(){
    super.initState();
 savedImages.addAll(widget.details.images);
  }

  Future getImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState((){
        savedImages.add(image.path);
        addedImages.add(image.path);
      });
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
        bottom: 5.0,
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
          "Add Image",
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        onPressed: () {
          //do image upload...
               },
      ),
    );

    return Scaffold(
      
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Watch images",
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),actions: <Widget>[
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
            Icons.image,
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
            // the internet images
            Expanded(
              child: GridView.builder(
                itemCount: savedImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (context, index) {
                     return 
                    savedImages[index].contains("http")?
                    Stack(
                      children: [
                        
                       CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        imageUrl: savedImages[index],
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
                      ),

                      Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {
                                    // remove image
                                    setState(() {
                          
                                      savedImages.remove(savedImages[index]);
                                      //remove from database...
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
                    ):
                    Stack(
                            children: [
                              Image.file(
                                File(savedImages[index]),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {
                                    // remove image
                                    setState(() {
                          
                                      savedImages.remove(savedImages[index]);
                                      addedImages.remove(addedImages[index]);
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
                  },),
            ),

            Visibility(
                visible: addedImages.isNotEmpty ? true : false, child: addImage),
          ],
        ),
      ),
    );
  }
}
