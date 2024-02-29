import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WatchImageView extends StatelessWidget{

  const WatchImageView({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),),
    );
  }
}