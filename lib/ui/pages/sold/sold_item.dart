import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_vault/models/sold_item_model.dart';

import '../../../models/firebase_user.dart';
import '../../../database_collection/users.dart';
import 'sold_item_details.dart';


class SoldItem extends StatelessWidget {
  const SoldItem({Key? key, required this.soldItem}) : super(key: key);

  final SoldItemModel soldItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SoldItemDetails(
                      soldItem: soldItem,
                    )));
      },
      child: Container(
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
              imageUrl: soldItem.images[0],
              imageBuilder: (context, imageProvider) => Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5.0,
                  ),
                  child: Text(
                    "${soldItem.brand} ${soldItem.model}",
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // sold to
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5.0,
                  ),
                  child: FutureBuilder(
                      future: Users(
                        userId: soldItem.soldTo,
                      ).userData,
                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                         UserData userData = UserData.fromDocument(snapshot.data!);
                          return Text(
                            "Sold to: ${userData.username}",
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
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5.0,
                  ),
                  child: Text(
                    DateFormat('dd MMM yyyy, hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(soldItem.date),
                      ),
                    ),
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
