import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/database_collection/chat.dart';
import '../../../models/chat_item_model.dart';
import '../../../database_collection/users.dart';
import '../../../ui/widgets/dialog.dart';
import '../../../utils/all_constants.dart';
import '../../widgets/text.dart';
import '../users/watch_user_item.dart';
import 'conversation.dart';
import 'widgets/chat_list_item.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  Stream? stream;
  bool isSearching = false;
  TextEditingController searchBoxController = TextEditingController();
  late UserData user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    user = Provider.of<UserData>(context);
    //stream = ChatService(userId: user.id).getChats();
  }

  void onItemClick(UserData userData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Conversation(
                  listItem: userData.id,
                )));
  }

  _searchUser(String value) {
    setState(() {
      isSearching = true;
      stream = Users(userId: "").queryUserDatabase("search", value.toLowerCase());
    });
  }

  Widget searchBox(){
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
      child: TextFormField(
        style: textStyle(fontSize:14.0, color: AppColors.textColor),
        controller: searchBoxController,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: textStyle(fontSize:14.0, color: AppColors.textColor),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const ImageIcon(
            AssetImage("assets/images/search.png"),
            color: AppColors.backgroundColor,
          ),
          suffixIcon: isSearching
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.backgroundColor,
                    size: 18.0,
                  ),
                  onPressed: () {
                    if (searchBoxController.text.isNotEmpty) {
                      searchBoxController.clear();
                    } else {
                      setState(() {
                        //stream = ChatService(userId: user.id).getChats();
                        isSearching = false;
                      });
                    }
                  },
                )
              : null,
        ),
        onChanged: (value) {
          _searchUser(value.toString());
        },
        validator: ((value) => value!.trim().isEmpty ? "Enter username" : null),
      ),
    );
  }

    
  Widget searchResult(BuildContext context, AsyncSnapshot snapshot) {
    List<UserData> usersList = List.empty(growable: true);

    for (DocumentSnapshot document in snapshot.data.docs) {
      usersList.add(UserData.fromDocument(document));
    }
    return usersList.isNotEmpty
        ? ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (BuildContext context, int index) {
              return UserItem(
                userData: usersList[index],
                onItemClick: onItemClick,
              );
            },
          )
        : Center(
            child: customText(
              "No Result",fontSize:12.0,fontWeight: FontWeight.bold,
            ),
          );
  }

  Widget recentsChats(BuildContext context, AsyncSnapshot snapshot) {
    List<ChatItemModel> chatList = List.empty(growable: true);

    for (DocumentSnapshot document in snapshot.data.docs) {
      chatList.add(ChatItemModel.fromDocument(document));
    }

    return chatList.isNotEmpty
        ? ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatItem(chatItem: chatList[index]);
            },
          )
        : Center(
            child: customText(
              "No Recent chats",fontSize:12.0,fontWeight: FontWeight.bold,
            ),
          );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      if (isSearching) {
        return searchResult(context, snapshot);
      } else {
        return recentsChats(context, snapshot);
      }
    } else {
      return const Center(
        child: LoadingDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            searchBox(),
            Expanded(
              child: isSearching?StreamBuilder(
                stream: stream, 
                builder: builder):StreamBuilder(
                stream: ChatService(userId: user.id).getChats(), 
                builder: builder),
            ),
          ],
        ),
      ),
    );
  }
}
