import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/message_model.dart';
import 'package:watch_vault/models/firebase_user.dart';

class ChatDetailsItem extends StatelessWidget{

 const ChatDetailsItem({Key? key, required this.doc}) : super(key: key);

final DocumentSnapshot? doc;

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserData>(context);

    MessageModel msg = MessageModel.fromDocument(doc!);
    
    return Container(
      margin: EdgeInsets.only(
        left: (msg.sender  == user.id?100:10),
        right: (msg.sender  == user.id?10:100),
      ),
      padding: const EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
      child: Align(
        alignment: (msg.sender == user.id?Alignment.topRight:Alignment.topLeft),
        child: msg.messageType == AppConstants.text?
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (msg.sender  == user.id?Colors.grey.shade200:Colors.grey[200]),
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            msg.content, style: 
          const TextStyle(fontSize: 15),
          softWrap: true,
          ),
        ):SizedBox(
          child: msg.content.contains("http")?
          CachedNetworkImage(
                  color: Colors.black.withOpacity(0.9),
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  imageUrl: msg.content,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 250,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ):
                Container(
                  width: 250,
                    height: 300,
        decoration: const BoxDecoration(
          
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child:const Center(
          child: SizedBox(
            width: 30,
                        height: 30,
            child: CircularProgressIndicator()),
        ),)
        ),
      ),
    );
  }

}