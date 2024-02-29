import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/models/firebase_user.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.userData, required this.onItemClick})
      : super(key: key);

  final UserData userData;
  final Function onItemClick;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          minimumSize: const Size(double.infinity, 70.0),
        ),
        onPressed: () {
          onItemClick(userData);
        },
        child: Row(
          children: [
            Container(
              child: userData.dp == "default"
                  ? const CircleAvatar(
                      radius: 25.0,
                      child: Icon(
                        Icons.person,
                        size: 24.0,
                        color: Colors.white,
                      ),
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
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 25.0,
                        backgroundImage: imageProvider,
                      ),
                    ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Center(
              child: Text(
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
