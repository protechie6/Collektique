import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import '../../../../models/firebase_user.dart';
import '../../../../models/inbox_model.dart';
import '../../../../database_collection/users.dart';
import 'inbox_item.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => InboxState();
}

class InboxState extends State<Inbox> {

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<FirebaseUser?>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inbox",
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
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: StreamBuilder(
          stream:Users(userId: user!.uid).allInbox,
          builder: builder),
        )
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot){
    if(snapshot.connectionState ==  ConnectionState.done){
      if(snapshot.hasData){
        List<InboxModel> inboxItems =
                      List.empty(growable: true);
                  for (DocumentSnapshot document in snapshot.data.docs) {
                    inboxItems.add(InboxModel.fromDocument(document));
                  }
        return ListView.builder(
                itemCount: inboxItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return InboxItem(
                    inboxItem: inboxItems[index],
                  );
                },
              );
      }else{
        return const Text("Empty");
      }
    }else{return Container();}
  }
}
