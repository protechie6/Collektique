import 'package:flutter/material.dart';
import 'package:watch_vault/models/notification_model.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:intl/intl.dart';
import '../../../../database_collection/user_notification_service.dart';
import '../../account/inbox/inbox.dart';
import '../../account/saved items/saved_item.dart';
import '../../library/my_library.dart';

class NotificatonItem extends StatelessWidget{
  
  const NotificatonItem({Key? key, required this.notification,}) : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    
    Widget title = Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 20.0, left:20.0),
      child: Text(notification.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1)),
    );

    Widget content = Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 20.0, left:20.0),
      child: Text(notification.content,
              style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1)),
    );

    Widget date = Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 20.0, left:20.0, bottom: 10.0),
      child: Text(DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(notification.date),
                        ),
                        ),
              style: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1)),
    );

     Widget indicator = Visibility(
      visible: notification.isSeen=="no"?true: false,
       child: Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 10,
                        left: 10.0,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius:  BorderRadius.all(Radius.elliptical(5, 5)),
                        ),),
     );

    return GestureDetector(
      onTap: () {
        UserNotificatonService(userId: "").isSeen(notification.id);
        switch(notification.type){

          case "inbox":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Inbox()),
          );
          break;

          case "transfer":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyLibrary()),
          );
          break;

          case "share":
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SavedItem()),
          );
          break;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top:20.0, left:20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible:true,
                child: indicator)
            ),
            title,
            content,
            date,
          ]
        )
      ),
    );
  }

}