import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/library.dart';

import '../../../../models/my_library_model.dart';

class PublicOrPrivate extends StatefulWidget{

  const PublicOrPrivate({Key? key, required this.details}) : super(key: key);

  final MyLibraryModel details; 

  @override
  State<StatefulWidget> createState() => PublicOrPrivateState();

}

class PublicOrPrivateState extends State<PublicOrPrivate>{

  String? view;

  @override
  void initState() {
    super.initState();

    view = widget.details.view;
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser?>(context);

    Widget publicView = Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Column(
        children: [
          RadioListTile(
                    title: const Text("Public",
                    style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1 /*PERCENT not supported*/
                )),
                    value: "public", 
                    groupValue: view, 
                    activeColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value){
                      setState(() {
                          view = value.toString();
                      });
                      // do update
                      LibraryDatabaseService(userId: user!.uid)
                      .updateLibraryItemView(view!, widget.details.itemId,widget.details);
                    },
                ),

                const Padding(
                  padding: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Text("Make watch visible to the public. It will be automatically added to user libraries",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 12,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                ),),)
        ],
      ),
    );

    Widget line = Container(
      margin: const EdgeInsets.only(
        top: 50.0,
      ),
        height: 1.0,
        width: double.infinity,
        color:Colors.white10,
    );
    
    Widget privateView = Container(
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Column(
        children: [
          RadioListTile(
                    title: const Text("Private",
                    style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 16,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1 /*PERCENT not supported*/
                )),
                    value: "private", 
                    groupValue: view, 
                    activeColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value){
                      setState(() {
                          view = value.toString();
                      });
                      // do update of library item
                      LibraryDatabaseService(userId: user!.uid)
                      .makePrivateView(view!, widget.details.itemId,);
                    },
                ),

                const Padding(
                  padding: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Text("Make watch visible to only you. It will not be added to user libraries",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 12,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1.5 /*PERCENT not supported*/
                ),),)
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.details.brand} ${widget.details.model}",
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 15,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1.0,
          ),
        ),
        centerTitle: true,
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            publicView,
            line,
            privateView,
          ],
        ),
      ),
    );

  }

}