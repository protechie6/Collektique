import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../models/my_library_model.dart';
import '../../../../database_collection/library.dart';

class TopAssets extends StatelessWidget{
  final String userId;
  const TopAssets({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream:LibraryDatabaseService(userId: userId).getTopAssets(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData) {
                  List<MyLibraryModel> libraryItems =
                      List.empty(growable: true);

                  for (DocumentSnapshot document in snapshot.data.docs) {
                    libraryItems.add(MyLibraryModel.fromDocument(document));
                  }

                  return libraryItems.isNotEmpty?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
                imageUrl: libraryItems[0].images[0],
                imageBuilder: (context, imageProvider) => Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(
                child: libraryItems.length>1? CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  imageUrl: libraryItems[1].images[0],
                  imageBuilder: (context, imageProvider) => Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ):Container(),
              ),
                  ],):Container();
                } else {
                  return Container();
                }
          });
  }
}