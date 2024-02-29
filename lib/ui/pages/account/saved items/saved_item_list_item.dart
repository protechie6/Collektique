import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_vault/models/saved_item_model.dart';

import '../../../widgets/text.dart';

class SavedItemListView extends StatelessWidget{

 const SavedItemListView({Key? key, required this.savedItem}) : super(key: key);

  final SavedItemModel savedItem;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: savedItem.images[0],
            imageBuilder: (context, imageProvider) => Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              // item name
              Padding(
                padding: const EdgeInsets.only(left: 10, top:5.0,),
                child: customText(
                  "${savedItem.brand} ${savedItem.model}",
                      fontSize: 14,),
              ),

              // Shared by
              Padding(
                padding: const EdgeInsets.only(left: 10, top:5.0,),
                child: Visibility(
                  visible: savedItem.sharedBy==''?false:true,
                  child: customText(
                    "Shared by: ${savedItem.sharedBy}",
                        fontSize: 14,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top:5.0,),
                child: customText(
                  DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(savedItem.date),
                        ),
                      ),
                      fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}