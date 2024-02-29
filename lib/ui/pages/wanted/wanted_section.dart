import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:watch_vault/ui/pages/wanted/upload_wanted.dart';
import 'package:watch_vault/database_collection/wanted_database.dart';

import '../../../utils/app_color.dart';
import '../../../ui/widgets/dialog.dart';
import 'wanted_watches_item.dart';

class WantedSection extends StatefulWidget {
  const WantedSection({Key? key}) : super(key: key);

  @override
  State<WantedSection> createState() => WantedSectionState();
}

class WantedSectionState extends State<WantedSection> {
  
  int page = 1;

   late ScrollController _scrollController;
   
     bool  isTop = true;
     
       bool isSearching = false;

       Stream? stream;

 @override
  void initState(){
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset>=_scrollController.position.maxScrollExtent 
    && !_scrollController.position.outOfRange) {
        isTop = false;
      } if(_scrollController.offset<=_scrollController.position.minScrollExtent 
    && !_scrollController.position.outOfRange){
      isTop = true;
      }
    });
    stream = WantedWatchDatabase().wantedWatchData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

Widget searchBox = Container(
        margin: const EdgeInsets.only(
          top: 0,
          bottom: 20,
        ),
        child: TextFormField(
          style: const TextStyle(
              fontSize: 15.0,
              color: AppColors.textColor,
              fontFamily: 'Poppins'),
          decoration: const InputDecoration(
              hintText: "search by brand",
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: AppColors.textColor,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: ImageIcon(
                AssetImage("assets/images/search.png"),
                color: AppColors.textColor,
              )),
          onChanged: (value) {
            setState(() {
              stream = WantedWatchDatabase().queryWantedWatchDatabase("brand", value.toString());
            });
          },
        ),
    );

    Widget gridview = NotificationListener<UserScrollNotification>(
      onNotification: ((notification) {
        final ScrollDirection direction = notification.direction;
        setState(() {
          if(direction == ScrollDirection.reverse){//when we are scrolling towards the end of the list
            
            setState((){
              if(isTop){
                  setState(() => page++,);
                }
            });
          }else if(direction == ScrollDirection.forward){//when we are scrolling towards the beginning of the list
           
            setState((){
                if(page!=1){
                  page--;
                }
              });
          }
        });
        return true;
      }),
      child: StreamBuilder(
        stream:isSearching?stream:WantedWatchDatabase().wantedWatchData,
        builder: builder));

    Widget button = Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: const Text("Upload",
            style: TextStyle(
                color: Color.fromRGBO(32, 72, 72, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1 /*PERCENT not supported*/
                )),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadWanted()),
          );
        },
      ),
    );

    Widget row2 = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         Text(
          "$page",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ), // <-- Text
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {
            final screenHeight = MediaQuery.of(context).size.height;
            _scrollController.animateTo(screenHeight,
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
                if(isTop){
                  setState(() => page++,);
                }
          },
          icon: const Icon(
            // <-- Icon
            Icons.skip_next,
            size: 24.0,
            color: Colors.white,
          ),
        )
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              searchBox,
              Expanded(
                child: gridview,
              ),
              button,
              row2,
            ],
          ),
        ),
      ),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {

    if(snapshot.hasData){
      return snapshot.data.docs.isNotEmpty ? GridView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: snapshot.data.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 220),
      itemBuilder: (BuildContext context, int index) {
        return WantedWatchItem(data: snapshot.data?.docs[index],);
      },
    ): const Center(
      child: Text(
            "No wanted watch",
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
}
