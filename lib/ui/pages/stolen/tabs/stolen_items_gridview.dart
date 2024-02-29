import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/database_collection/stolen_database.dart';
import '../../../../models/stolen_watches_model.dart';
import '../../../../ui/widgets/dialog.dart';
import '../stolen_watch_details.dart';

class StolenItemGridView extends StatelessWidget {
  const StolenItemGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

return Padding(
  padding: const EdgeInsets.all(20.0),
  child:   StreamBuilder(
  
            stream:StolenWatchDatabase().stolenWatchData,
  
             builder: builder),
);
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if(snapshot.hasData){
      List<StolenWatchModel> stolenItems = List.empty(growable: true);

        for (DocumentSnapshot document in snapshot.data.docs) {
          stolenItems.add(StolenWatchModel.fromDocument(document));
        }
      return stolenItems.isNotEmpty ? GridView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: 220),
          itemBuilder: (BuildContext context, int index) {
            return StolenWatchItem(stolenWatch: stolenItems[index],); // GridItem
          },
        ): const Center(
        child: LoadingDialog(),
      );
      
    }else{
      return const Center(
        child: Text(
          "No stolen watch",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 12,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
        ),
      );
    }
  }
}

// GridItem class

class StolenWatchItem extends StatelessWidget {
  const StolenWatchItem({
    Key? key,
    required this.stolenWatch,
  }) : super(key: key);

  final StolenWatchModel stolenWatch;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StolenWatchesDetails(itemDetails: stolenWatch)));
      },
      child: Column(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: stolenWatch.images[0],
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${stolenWatch.brand} ${stolenWatch.model}",
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
          ),
        ],
      ),
    );
  }
}

