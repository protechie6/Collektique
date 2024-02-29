import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/notification_model.dart';

import 'widget/notification_item.dart';
import '../../../models/firebase_user.dart';
import '../../../database_collection/user_notification_service.dart';
import '../../../ui/widgets/dialog.dart';

class Notifications extends StatelessWidget{
  
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser?>(context);

    Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if(snapshot.hasData){
      
      List<NotificationModel> notificationList =
                      List.empty(growable: true);

                  for (DocumentSnapshot document in snapshot.data.docs) {
                    notificationList.add(NotificationModel.fromDocument(document));
                  }
                  
         return notificationList.isNotEmpty
         ? ListView.builder(
                itemCount: notificationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificatonItem(notification: notificationList[index],
                  );
                },
              ):
              const Center(
          child: Text(
            "No Notifications",
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
      }else{
        return const Center(
            child: LoadingDialog(),
        );
      }
  }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),),
            leading:IconButton(
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
      body: StreamBuilder(
        stream:UserNotificatonService(userId: user!.uid).userNotifications(),
        builder: builder),
    );
  }

}