import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/database_collection/user_notification_service.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/my_library_model.dart';
import 'package:watch_vault/database_collection/library.dart';
import 'package:watch_vault/database_collection/users.dart';
import '../../../ui/widgets/dialog.dart';
import '../../widgets/text.dart';
import '../account/security/passcode.dart';
import '../users/watch_user_item.dart';
import 'payments_details.dart';

class TransferOrShare extends StatefulWidget {

  const TransferOrShare({Key? key, required this.routeTitle, required this.details}) : super(key: key);

  final String routeTitle;
  final MyLibraryModel details; 

  @override
  State<TransferOrShare> createState() => TransferOrShareState();
}

class TransferOrShareState extends State<TransferOrShare> {

  Stream? stream;
  UserData? currentUser;
  late NavigatorState _navigator;
  bool isEnteringPin = false;
  String? receiverId;


  void transferOrShare(){
    if(widget.routeTitle =="Share with member"){
        LibraryDatabaseService(userId: currentUser!.id).shareWithMember(widget.details, receiverId!, currentUser!.username)
        .whenComplete(()=>
          UserNotificatonService(userId: '').sendNotification(receiverId!,'SHARED ITEM', '${currentUser!.username} has shared an item with you.', 'share').whenComplete((){
            _navigator.pop(context);
            ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Sharing successful!'),backgroundColor: AppColors.buttonColor1,padding: EdgeInsets.all(15.0),));
        }));
          
      }else{
      Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentDetails(accountType: '\$10',)),
              );
        /*LibraryDatabaseService(userId: currentUser!.id).transferToMember(widget.details, receiverId!)
        .whenComplete(()=>UserNotificatonService(userId: '').sendNotification(receiverId!,'ITEM TRANSFER', 'An item has been transfered to you.','transfer').whenComplete((){
            _navigator.pop(context);
            ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: const Text('Transfer successful!'),
        backgroundColor: AppColors.buttonColor1,
        padding: const EdgeInsets.all(15.0),
        action: SnackBarAction(label: 'label', onPressed:(){
          _navigator.pop(context);
        },
        textColor: AppColors.backgroundColor,),
        )
        );
        }
        )
        ); */
      }
  }

  void _showBottomButton(UserData userData, String msg) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: (MediaQuery.of(context).size.height) * 0.25,
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
               Padding(
                padding: const EdgeInsets.only(top:20.0, right:20.0, left:20.0, bottom:0.0 ),
                child: customText(
                  widget.routeTitle,fontSize:18.0,
                  textAlign:TextAlign.start,),
              ),
               Padding(
                padding:const EdgeInsets.all(14.0),
                child: customText(
                  msg,fontSize:16.0,
                  textAlign:TextAlign.start,
                ),
              ),Row(children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: customText(
                      "No", fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                       setState(() {
                            isEnteringPin = true;
                            receiverId = userData.id;
                          });
                    },
                    child: customText(
                      "Yes", fontSize: 16.0,),
                  ),
                  const SizedBox(width: 20.0),
                ]),
            ],
          ),
        );
      },
    );
  }

  void onItemClick(UserData userData){
    if(widget.routeTitle == "Share with member"){
      String msg = "Share ${widget.details.brand} ${widget.details.model} with ${userData.username} ?";
      _showBottomButton(userData, msg);
    }else{
      String msg = "Transfer ${widget.details.brand} ${widget.details.model} to ${userData.username} ? It will cost you £10";
    _showBottomButton(userData, msg);
    }
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    currentUser = Provider.of<UserData>(context);

    Users databaseService =
        Users(userId: currentUser!.id);

    stream = databaseService.allUsers;

   _navigator = Navigator.of(context);

  }

  @override
  Widget build(BuildContext context) {

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

    return isEnteringPin? PassCode(
                      actions: 'ENTER PIN',
                       isPinCorrect: (bool value) {
                        if(value){
    transferOrShare();
                        }
                       },
                    ):
                     Scaffold(
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
            customText(
          widget.routeTitle, fontSize: 18.0,),
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
      ):const Center(
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
      return const LoadingDialog();
    }
  }
}
