import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../widgets/text.dart';

class BoxAndPapers extends StatelessWidget {
   const BoxAndPapers({Key? key,
  required this.boxAndPapers, required this.activity}) : super(key: key);

  final List<String> boxAndPapers;
  final String activity;

   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: customText(activity,
              fontSize: 15,),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 6,
          itemCount: boxAndPapers.length, 
          itemBuilder: itemBuilder),),);
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10.0),      child:CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: boxAndPapers[0],
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
    );
  }
}
