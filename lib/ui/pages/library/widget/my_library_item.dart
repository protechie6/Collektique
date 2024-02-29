import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/my_library_model.dart';
import '../../../../utils/ui_utils.dart';
import '../../stolen/upload_stolen_watch.dart';
import '../my_library_item_detail_bag.dart';
import '../my_library_item_detail_car.dart';
import '../my_library_item_details_shoe.dart';
import '../my_library_item_details_watch.dart';

class MyLibraryItem extends StatefulWidget {

  const MyLibraryItem({
    Key? key,
    required this.itemKey,
    required this.data,
    this.fromSale = false,
    this.fromStolen = false,
    this.isPublicView = false,
    required this.isSelected,
  }) : super(key: key);

  final MyLibraryModel data;
  final bool fromSale;
  final bool fromStolen;
  final bool isPublicView;

  final ValueChanged<bool> isSelected;
  final Key itemKey;

  @override
  State<StatefulWidget> createState() => MyLibraryItemState();
}

class MyLibraryItemState extends State<MyLibraryItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.fromSale) {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        } else if (widget.fromStolen) {
          if(widget.data.type != AppConstants.watch){
            UiUtils.customSnackBar(context, msg: 'Please select a stolen watch item');
          }else{
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return UploadStolenWatch(data: widget.data,);
          }));
          }
        }else {
          showItemDetails();
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              CachedNetworkImage(
                color: Colors.black.withOpacity(isSelected ? 0.4 : 0),
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
                imageUrl: widget.data.images[0],
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${widget.data.brand} ${widget.data.model}",
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
          isSelected
              ? const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void showItemDetails() {
    switch (widget.data.type) {
      case AppConstants.bag:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyLibraryItemDetailsBag(
                      itemDetails: widget.data,
                    )));
        break;

      case AppConstants.shoe:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyLibraryItemDetailsShoe(
                      itemDetails: widget.data,
                    )));
        break;

      case AppConstants.car:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyLibraryItemCarDetails(
                      itemDetails: widget.data,
                    )));
        break;

      default:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyLibraryItemDetailsWatch(
                      itemDetails: widget.data,
                    )));
        break;
    }
  }
}
