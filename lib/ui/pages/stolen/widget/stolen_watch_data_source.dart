import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/stolen_watches_model.dart';
import 'package:watch_vault/database_collection/users.dart';

import '../../message/conversation.dart';

class StolenWatchesDataSource extends DataTableSource{

  final List<StolenWatchModel> docs;

  StolenWatchesDataSource({
    required this.docs,
  });

  @override
  DataRow? getRow(int index) {

    return DataRow(cells: [
      DataCell(Text(docs[index].year,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),),),
      DataCell(Text(docs[index].model,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),),),

      DataCell(Text(docs[index].serialNumber,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),),),
      DataCell(Text(docs[index].dateStolen,
      style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),),),

    DataCell(FutureBuilder(
            future: Users(userId: docs[index].userId).userData,
            builder: builder)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => docs.length;

  @override
  int get selectedRowCount => 0;


  Widget builder(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

    final user = Provider.of<FirebaseUser?>(context);

    if (snapshot.connectionState == ConnectionState.done) {
      UserData userData = UserData.fromDocument(snapshot.data!);
      return 
      GestureDetector(
        onTap: (){
          if(user!.uid != userData.id){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Conversation(listItem: userData.id)),
          );
          }
        },
      child: Text(
            userData.username,
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 14,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                ),
                overflow: TextOverflow.ellipsis,
          ),);
      }
      else{
        return const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          );
      }
  }
} 