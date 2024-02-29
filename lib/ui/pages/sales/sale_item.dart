import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/models/sales_model.dart';

import 'sale_item_details.dart';


class SaleItem extends StatelessWidget {
  const SaleItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DocumentSnapshot data;

  @override
  Widget build(BuildContext context) {
    SalesWatchModel saleWatch = SalesWatchModel.fromDocument(data);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaleItemDetails(
              itemDetails: saleWatch,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            imageUrl: saleWatch.images[0],
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${saleWatch.brand} ${saleWatch.model}",
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
