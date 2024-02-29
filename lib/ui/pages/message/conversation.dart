import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/chat.dart';
import 'package:watch_vault/database_collection/users.dart';

import '../users/public_view_library.dart';
import 'widgets/conversation_item.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key, required this.listItem}) : super(key: key);

  final String listItem; // where listItem is the clicked item's userId

  @override
  State<Conversation> createState() => ConversationState();
}

class ConversationState extends State<Conversation> {

  TextEditingController myController = TextEditingController();

  ChatService? chatService;

  Stream? stream;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    final user = Provider.of<UserData>(context);
    
    chatService = ChatService(userId: user.id);

    stream = chatService!.getMessages(widget.listItem);
    
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
Future getImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      chatService!.sendMessage(image.path,widget.listItem,AppConstants.image);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  void _showBottomButton() {

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){

          return Container(
             height: (MediaQuery.of(context).size.height)*0.15,
            decoration: const BoxDecoration(
              color:  AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
 Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
        SizedBox.fromSize(
      size: const Size(48, 48),
      child: ClipOval(
        child: Material(
          color: Colors.blue,
          child: IconButton(
          icon:  const Icon(Icons.camera_alt, size: 24.0,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            getImage(ImageSource.camera);
          },
        ),
        ),
      ),
    ),

    const Padding(
      padding:  EdgeInsets.only(
        top: 8.0),
      child:  Text("Camera",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.0 /*PERCENT not supported*/
                          )),
    ), 
  ],
),

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
        SizedBox.fromSize(
      size: const Size(48, 48),
      child: ClipOval(
        child: Material(
          color: Colors.green,
          child: IconButton(
          icon:  const Icon(Icons.collections, size: 24.0,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            getImage(ImageSource.gallery);
          },
        ),
        ),
      ),
    ),

    const Padding(
      padding:  EdgeInsets.only(
        top: 8.0),
      child:  Text("Phone storage",style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.0 /*PERCENT not supported*/
                          )),
    ), 
  ],
)
              ],
            ),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {

    Widget buildMessageInput() {

      return Container(
        padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
        height: 80,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _showBottomButton();
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Color.fromRGBO(32, 72, 72, 1),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                String msg = myController.text;
                if (msg.trim().isNotEmpty) {
                  chatService!.sendMessage(msg,widget.listItem,AppConstants.text);
                  setState(() => myController.clear());
                }
              },
              backgroundColor: Colors.white,
              elevation: 0,
              child: const Icon(
                Icons.send,
                color: AppColors.buttonColor1,
                size: 18,
              ),
            ),
          ],
        ),
      );
    }

    Widget messageList() {
      return StreamBuilder(
        stream: stream,
        builder: builder);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<DocumentSnapshot>(
            future: Users(userId: widget.listItem).userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                UserData userData = UserData.fromDocument(snapshot.data!);
                return GestureDetector(
                  onTap:(){
                    Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WatchVaultUserLibrary(
                        userId: userData.id,
                      ),
                      ),
                      );
                  },
                  child: Text(
                    userData.username,
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  ),
                );
              } else {
                return const Text(
                  "Error getting user",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.5 /*PERCENT not supported*/
                      ),
                );
              }
            }),
        elevation: 0,
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                "End Chat",
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
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: messageList()),
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {     
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: false,
          itemBuilder: (BuildContext context, int index) {
            return ChatDetailsItem(
              doc: snapshot.data?.docs[index],
            );
          },
        );
      } else {
        return const Center(
          child: Text(
            "No messages",
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
      }
    } 
  }

