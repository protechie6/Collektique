import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_vault/utils/all_constants.dart';

import '../../../../models/inbox_model.dart';

class InboxItem extends StatelessWidget{

  const InboxItem({Key? key, required this.inboxItem}) : super(key: key);
  final InboxModel inboxItem;

  @override
  Widget build(BuildContext context) {

   return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: inboxItem.isSeen=="no"?true:false,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                ),
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                )),
            ),
          ),

           Padding(
            padding: const EdgeInsets.all(10), 
            child:  Text(inboxItem.content,
             style:  const TextStyle(
            color: AppColors.textColor,
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
        ))
              ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1.0,
              width: 130.0,
              color: Colors.black12,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
    children: [
     Text(DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(inboxItem.date),
                        ),
                      ),
     style: const TextStyle(
            color: AppColors.textColor,
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
        ),),
         // <-- Text
      const Spacer(),

      const Text("View",
     style: TextStyle(
            color: Color.fromARGB(255, 32, 72, 72),
            fontFamily: 'Poppins',
            fontSize: 12,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.5 /*PERCENT not supported*/
        ),),
    ],
  ),
          )
        ],
      ),
    );
  }

}