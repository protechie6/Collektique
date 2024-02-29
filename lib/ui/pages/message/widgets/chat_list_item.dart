import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_vault/models/chat_item_model.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';

import '../conversation.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.chatItem}) : super(key: key);

  final ChatItemModel chatItem;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Users(userId: chatItem.id).userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          final double screenWidth = MediaQuery.of(context).size.width;

          if (snapshot.hasData) {
            UserData userData = UserData.fromDocument(snapshot.data!);
            return Container(
              margin: const EdgeInsets.only(
                top: 20,
                left:20.0,
                right: 20.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 70.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Conversation(
                                listItem: chatItem.id,
                              )));
                },
                child: Row(
                  children: [
                    Container(
                      child: userData.dp == "default"
                          ? const CircleAvatar(
          radius: 24.0,
          child:Icon(Icons.person,
                  size: 24.0, color: Colors.white,),
        )
                          : CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                imageUrl: userData.dp,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.person),
                                    imageBuilder: (context, imageProvider) => CircleAvatar(
    radius: 24.0,
    backgroundImage: imageProvider,
   ),
                              ),
                    ),

                    const SizedBox(
                      width: 5.5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15.0,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        ),
                        SizedBox(
                          width: (screenWidth / 2.3),
                          child: Text(
                            chatItem.lastMessage,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1.5 /*PERCENT not supported*/
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ), // <-- Text
                    const Spacer(),
                    Text(
                      DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chatItem.time),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.5 /*PERCENT not supported*/
                          ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  minimumSize: Size(screenWidth, 70.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Conversation(
                                listItem: chatItem.id,
                              )));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image(
                            image:
                                Image.asset("assets/images/account_profile.png")
                                    .image),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "---",
                          style:  TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15.0,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        ),
                        SizedBox(
                          width: (screenWidth / 2),
                          child: const Text(
                            "---",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1.5 /*PERCENT not supported*/
                                ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ), // <-- Text
                    const Spacer(),
                    const Text(
                      "---",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.5 /*PERCENT not supported*/
                          ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
