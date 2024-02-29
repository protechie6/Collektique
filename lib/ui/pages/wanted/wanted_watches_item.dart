import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/models/wanted_watches_model.dart';
import 'wanted_section_details.dart';

class WantedWatchItem extends StatelessWidget {
  const WantedWatchItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DocumentSnapshot data;

  @override
  Widget build(BuildContext context) {

    WantedWatchModel wantedWatch = WantedWatchModel.fromDocument(data);

    return Column(
      children: [
        GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WantedSectionDetails(
                        itemDetails: wantedWatch,
                      )));
        },
        child:  CachedNetworkImage(
              placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
              imageUrl: wantedWatch.images[0],
              imageBuilder: (context, imageProvider) => Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
      
    ),
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text("${wantedWatch.brand} ${wantedWatch.model}",
      style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Poppins',
          fontSize: 14,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1.5 /*PERCENT not supported*/
          ),
      softWrap: true,
    ),
    )
      ],
    );
  }
}


