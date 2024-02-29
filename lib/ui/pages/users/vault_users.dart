import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/users.dart';
import '../../../ui/widgets/dialog.dart';
import 'watch_user_item.dart';

class WatchUsers extends StatefulWidget {

  const WatchUsers({Key? key,}) : super(key: key);

  @override
  State<WatchUsers> createState() => WatchUsersState();
}

class WatchUsersState extends State<WatchUsers> {

  Stream? stream;
  

  void onItemClick(UserData userData){
   /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WatchVaultUserLibrary(data: userData,
                    )));*/
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    Users databaseService =
        Users(userId:"");

    stream = databaseService.allUsers;
  }

  @override
  Widget build(BuildContext context) {

    Widget title = Container(
      margin: const EdgeInsets.only(
        top:0.0),

        child: const Text(
          "User libraries",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 18.0,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1.5),
        ),
    );

    Widget searchBox = Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0,
            color: Color.fromARGB(255, 32, 72, 72),
            fontFamily: 'Poppins'),
        decoration: const InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 32, 72, 72),
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: ImageIcon(
              AssetImage("assets/images/search.png"),
              color: Color.fromARGB(255, 32, 72, 72),
            )),
        onChanged: (value) {
          // do search on database 
          setState((){
            stream = Users(userId: '').queryUserDatabase("username", value.toString());
          });
        },
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            searchBox,
            Expanded(
              child: StreamBuilder(stream: stream, builder: builder),
            ),
          ],
        ),
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<UserData> usersList =
                      List.empty(growable: true);

                  for (DocumentSnapshot document in snapshot.data.docs) {
                    usersList.add(UserData.fromDocument(document));
                  }
      return usersList.isNotEmpty? ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return UserItem(userData: usersList[index], onItemClick: onItemClick,);
        },
      ): const Center(
      child: Text(
            "No User",
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
    } else {
      return const Center(
        child: LoadingDialog(),
      );
    }
  }
}
