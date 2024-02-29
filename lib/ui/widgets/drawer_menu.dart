import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/app_data_model.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/app_database_service.dart';
import 'package:watch_vault/services/auth_service.dart';
import '../pages/account/account_page.dart';
import '../pages/common/info.dart';
import '../pages/users/user_details.dart';
import 'text.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  
  vaultwatch(BuildContext context, String currentVersion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: customText(
          AppConstants.appName,
          textColor: AppColors.backgroundColor,
          fontSize: 16,
        ),
        content: SizedBox(
          height: 200.0,
          child: Column(
            children: [
              customText(
                "No new update at the moment",
                textColor: AppColors.backgroundColor,
                fontSize: 14,
              ),
              customText(
                "Current version is $currentVersion",
                textColor: AppColors.backgroundColor,
                fontSize: 14,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(8),
              child: customText(
                "Ok",
                textColor: AppColors.buttonColor1,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    Widget row1 = Container(
      margin: const EdgeInsets.only(
        top: 50,
        left: 10,
      ),
      child: Row(children: <Widget>[
        SizedBox(
          width: 200, // <-- Fixed width.
          child: customText(
            "Free",
            fontSize: 15,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const ImageIcon(
              AssetImage("assets/images/cancel.png"),
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );

    Widget userName = Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: customText(
        user.username,
        fontSize: 15,
      ),
    );

    Widget profileVisibility = Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: customText(
        "Profile visibillty",
        fontSize: 12,
      ),
    );

    Widget public = Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: customText(
        "Public",
        fontSize: 12,
      ),
    );

    Widget profilePicture() {
      if (user.dp == "default") {
        return const CircleAvatar(
          radius: 20,
          child: Icon(
            Icons.person,
            size: 20.0,
            color: Colors.white,
          ),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: user.dp,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 20,
            backgroundImage: imageProvider,
          ),
        );
      }
    }

    Widget accountButton = Container(
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40.0),
        ),
        onPressed: () async {
          Navigator.pop(context);
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Account()));
        },
        child: Row(
          children: [
            const ImageIcon(
              AssetImage("assets/images/account_profile.png"),
              size: 15,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Account",
              fontSize: 14,
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ],
        ),
      ),
    );

    Widget userDetailsButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40.0),
        ),
        onPressed: () async {
          Navigator.pop(context);
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserDetails()));
        },
        child: Row(
          children: [
            const ImageIcon(
              AssetImage("assets/images/user_details.png"),
              size: 15,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "User Details",
              fontSize: 14,
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ],
        ),
      ),
    );

    Widget shareWithFriendButton(String shareLink) {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            minimumSize: const Size(double.infinity, 40.0),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await Share.share("Hey there! $shareLink");
          },
          child: Row(
            children: [
              const Icon(
                Icons.share,
                size: 18.0,
              ),
              const SizedBox(
                width: 20,
              ),
              customText(
                "Share with friends",
                fontSize: 15,
              ), // <-- Text
              const Spacer(),
              const Icon(
                // <-- Icon
                Icons.arrow_forward_ios,
                size: 18.0,
              ),
            ],
          ),
        ),
      );
    }

    Widget vaultWatchButton(AppDataModel data) {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            minimumSize: const Size(double.infinity, 40.0),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Info()));
          },
          child: Row(
            children: [
              const Icon(
                Icons.watch_later,
                size: 18.0,
              ),
              const SizedBox(
                width: 20,
              ),
              customText(
                AppConstants.appName,
                fontSize: 15,
              ), // <-- Text
              const Spacer(),
              const Icon(
                // <-- Icon
                Icons.arrow_forward_ios,
                size: 18.0,
              ),
            ],
          ),
        ),
      );
    }

    Widget line = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
    );

    Widget signOut = Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 10,
      ),
      child: TextButton.icon(
        onPressed: () async {
          await AuthService().signOutUser();
        },
        icon: const ImageIcon(
          AssetImage("assets/images/clarity_logout.png"),
          color: Colors.white,
        ),
        label: customText(
          "Sign Out",
          fontSize: 14,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          row1,
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profilePicture(),
                userName,
                profileVisibility,
                public,
              ],
            ),
          ),
          accountButton,
          userDetailsButton,
          FutureBuilder(
            future: VaultDatabaseService().appData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                AppDataModel data = snapshot.data;
                return Column(children: [
                  shareWithFriendButton(data.playStoreLink),
                  vaultWatchButton(data),
                ]);
              } else {
                return Container();
              }
            },
          ),
          const Spacer(),
          line,
          signOut
        ],
      ),
    );
  }
}
