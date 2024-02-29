import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/models/notification_model.dart';
import 'package:watch_vault/database_collection/user_notification_service.dart';
import 'package:watch_vault/ui/pages/message/chat_lists.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/ui/pages/home/home_tab.dart';
import 'package:watch_vault/ui/widgets/drawer_menu.dart';
import '../notification/user_notification.dart';
import '../users/public_view_library.dart';
import '../wanted/wanted_section.dart';
import 'package:watch_vault/ui/widgets/text.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState()=>HomeState();

}

class HomeState extends State<Home>{

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  
  int currentIndex = 0;

  final screens = const [HomeTab(), WatchVaultUserLibrary(),WantedSection(),ChatList()];

  /*@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
       init();
    });
    super.initState();
  }*/

  void init(){
    /*if(user.libraryCollections.isEmpty){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LibraryPreference()),
              );
              }*/
  }


  Widget appBarTitle(){

    late String title;

    switch(currentIndex){

      case 0:
      title = "Home";
      break;

      case 1:
      title = "User libraries";
      break;

      case 2:
      title = "Wanted";
      break;

      case 3:
      title = "Chat";
      break;
    }
    return customText(title,fontSize: 15.0,fontWeight: FontWeight.bold);
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);
    return exitResult ?? false;
  }
    Future<bool?> _showExitBottomSheet(BuildContext context)async{
    return await showModalBottomSheet(
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
                padding: const EdgeInsets.only(top:20.0, bottom:15.0, left:20.0, right:20.0),
                child: customText('Exit',fontSize: 18.0,fontWeight: FontWeight.bold,textAlign:TextAlign.start),
              ),
                Padding(
                padding: const EdgeInsets.all(20.0),
                child: customText('Are you requesting to exit?',fontSize: 16.0, textAlign:TextAlign.start),
              ),Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: customText('No',fontSize: 16.0,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 30.0),
                  TextButton(
                    onPressed: () {
                       Navigator.of(context).pop(true);
                    },
                    child:customText('Yes',fontSize: 16.0,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20.0),
                ]),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double drawerWidth = (MediaQuery.of(context).size.width) * 0.80;
    final user = Provider.of<FirebaseUser?>(context);

    return  WillPopScope(
      onWillPop:() => _onWillPop(context),
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          centerTitle: true,
          title:appBarTitle(),
          leading:GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const ImageIcon(AssetImage("assets/images/drawer_menu.png")),
            ),
          elevation: 0,
          actions: <Widget>[
            Visibility(
              visible: currentIndex==0?true:false,
              child: Container(
                width: 30.0,
                height: 30.0,
                margin: const EdgeInsets.only(right: 20.0),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                      builder: (context) => const Notifications()),
            );
                      },
                    ),
    
                    Align(
                      alignment: Alignment.topRight,
                      child: StreamBuilder(
                        stream: UserNotificatonService(userId: user!.uid).userNotificationsAlert(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            List<NotificationModel> notifications =
                        List.empty(growable: true);
    
                    for (DocumentSnapshot document in snapshot.data.docs) {
                      notifications.add(NotificationModel.fromDocument(document));
                    }
                    return notifications.isNotEmpty?Container(
                        width:12.0,
                        height: 12.0,
                            margin: const EdgeInsets.only(top:15,
                            left: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red, 
                              shape: BoxShape.circle,
                               border: Border.all(
                              width: 3,
                              color: AppColors.backgroundColor,
                            )
                            ),): const SizedBox();
                            
                          }else{
                            return const SizedBox();
                          }
                          
                        }
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          width: drawerWidth,
        backgroundColor: AppColors.backgroundColor,
          child: const DrawerMenu(),
        ),
        body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=>setState(()=>currentIndex = index),
        backgroundColor: AppColors.backgroundColor,
        iconSize: 18.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.buttonColor1,
        unselectedItemColor: AppColors.white,
        items: const [
        BottomNavigationBarItem(
          icon:  Icon(
            Icons.home,
            ),
            label: 'Home'),
    
            BottomNavigationBarItem(
          icon:  ImageIcon(
            AssetImage("assets/images/user_libraries.png"),
            ),
            label: 'UserLibraries'),

            BottomNavigationBarItem(
          icon:  ImageIcon(
            AssetImage("assets/images/wanted.png"),
            ),
            label: 'Wanted'),

            BottomNavigationBarItem(
          icon:  Icon(
            Icons.chat,
            ),
            label: 'Chat'),
      ]),
      ),
    );
  }

}