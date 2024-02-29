import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../models/firebase_user.dart';
import 'edit_profile_picture.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  void editImage(BuildContext context, String? dp) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const EditProfilePicture()),
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData>(context);

    Widget profilePicture = SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          children: [
            SizedBox(
              child: user.dp == "default"
                  ? const CircleAvatar(
                      radius: 70,
                      child: Icon(
                        Icons.person,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      imageUrl: user.dp,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 70,
                        backgroundImage: imageProvider,
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => editImage(context, user.dp),
                child: Container(
                  margin: const EdgeInsets.only(
                    right:5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor1,
                    shape: BoxShape.circle,
                    border: Border.all(
        width: 3,
        color: AppColors.backgroundColor,
      ), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.edit, size: 24.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    
    Widget textsection1 = Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          user.username,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 20,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.bold,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
      );
  
    Widget textsection2 = Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          user.email,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 13,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1.5 /*PERCENT not supported*/
              ),
          softWrap: true,
        ),
      );
    
    Widget textsection3 = const Padding(
      padding: EdgeInsets.only(
        top: 30,
      ),
      child: Text(
        "Free Version 1.00124",
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 16,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
            ),
        softWrap: true,
      ),
    );

    Widget textsection4 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "3 free watch libaries public or private",
        style: TextStyle(
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
    );

    Widget textsection5 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "5X image upload per library item",
        textAlign: TextAlign.left,
        style: TextStyle(
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
    );

    Widget textsection6 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "Sales- upload, sell and browse",
        textAlign: TextAlign.left,
        style: TextStyle(
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
    );

    Widget textsection7 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "Wanted - upload, sell and browse",
        textAlign: TextAlign.left,
        style: TextStyle(
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
    );

    Widget textsection8 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "Stolen- Upload, view and browse",
        style: TextStyle(
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
    );

    Widget textsection9 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "View stolen watches",
        textAlign: TextAlign.left,
        style: TextStyle(
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
    );

    Widget textsection10 = const Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "Rolex serial number check",
        textAlign: TextAlign.left,
        style: TextStyle(
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
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
    body: Container(
                padding: const EdgeInsets.only(left:20.0, right:20.0, top:10.0, bottom:20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profilePicture,
                      textsection1,
                      textsection2,
                      textsection3,
                      textsection4,
                      textsection5,
                      textsection6,
                      textsection7,
                      textsection8,
                      textsection9,
                      textsection10,
                    ],
                  ),
                ),
    ),
    );
  }
}
