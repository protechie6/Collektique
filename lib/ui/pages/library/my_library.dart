import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/models/firebase_user.dart';
import 'package:watch_vault/ui/widgets/circular_indicator.dart';
import 'package:watch_vault/ui/pages/library/library_tabview.dart';
import '../previously owned/previously_owned.dart';
import '../sold/sold_section.dart';
import '../stolen/user_stolen_collections.dart';
import '../wanted/wanted_section.dart';
import 'library_preference.dart';
import 'search_library.dart';

class MyLibrary extends StatefulWidget {

  const MyLibrary({Key? key, this.fromSales = false, this.fromStolen = false}) : super(key: key);

  final bool fromSales;
  final bool fromStolen;

  @override
  State<MyLibrary> createState() => MyLibraryState();
}

class MyLibraryState extends State<MyLibrary> with TickerProviderStateMixin {
  // Initial Selected Value
  String dropdownvalue = "Category";

  late UserData user;

  late List<String> libraryCollections;

  // List of items in our dropdown menu
  var items = ["Category", "Sold", "Wanted", "Previously owned", "Stolen"];

  TabController? _controller;

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
       init();
    });
    super.initState();
  }

  void init(){
    if(user.libraryCollections.isEmpty){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LibraryPreference()),
              );
              }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    user = Provider.of<UserData>(context);
    setState(() {
      libraryCollections = user.libraryCollections;
    });
    _controller = TabController(length: libraryCollections.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    Widget title = Container(
      margin: const EdgeInsets.only(
        top: 0,
        bottom: 10.0,
        right: 20.0,
        left: 20.0,
      ),
      child: Row(children: <Widget>[
        const Text(
          "My Library",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(),
        Visibility(
          visible:(widget.fromSales||widget.fromStolen)? false : true,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchLibrary(userId: user.id,)),
                );
            },
            child: const ImageIcon(
              AssetImage("assets/images/search.png"),
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );

    Widget dropDown = Visibility(
      visible:(widget.fromSales||widget.fromStolen)? false : true,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(
            top: 0,
            bottom: 10.0,
            left: 20.0,
          ),
          child: DropdownButton(
            // Initial Value
            value: dropdownvalue,
            underline: Container(),
            dropdownColor: AppColors.backgroundColor,
            style: const TextStyle(color: Colors.white),
            // Down Arrow Icon
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 18.0,
              color: Colors.white,
            ),
    
            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              switch (newValue) {
                case "Sold":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SoldSection()));
                  break;
    
                case "Wanted":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WantedSection()));
                  break;
    
                case "Previously owned":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreviouslyOwned()));
    
                  break;
    
                  case "Stolen":
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> const UserStolenCollection()));
                  break;
              }
            },
          ),
        ),
      ),
    );

    Widget tabs() {
      switch (libraryCollections.length) {
        case 4:
          return Expanded(
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelPadding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    labelColor: AppColors.white,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: const DotIndicator(),
                    tabs: [
                      Tab(
                        text: libraryCollections[0],
                      ),
                      Tab(
                        text: libraryCollections[1],
                      ),
                      Tab(
                        text: libraryCollections[2],
                      ),
                      Tab(
                        text: libraryCollections[3],
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: [
                  LibraryTabView(
                    userId: user.id,
                    libraryCollection: libraryCollections[0],
                    fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                    accountType: user.accountType,
                  ),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[1],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[2],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[3],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                ]),
              ),
            ]),
          );

        case 3:
          return Expanded(
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelPadding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    labelColor: AppColors.white,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: const DotIndicator(),
                    tabs: [
                      Tab(
                        text: libraryCollections[0],
                      ),
                      Tab(
                        text: libraryCollections[1],
                      ),
                      Tab(
                        text: libraryCollections[2],
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: [
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[0],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[1],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[2],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                ]),
              ),
            ]),
          );

        case 2:
          return Expanded(
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelPadding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    labelColor: AppColors.white,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: const DotIndicator(),
                    tabs: [
                      Tab(
                        text: libraryCollections[0],
                      ),
                      Tab(
                        text: libraryCollections[1],
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: [
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[0],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[1],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                ]),
              ),
            ]),
          );

        case 1:
          return Expanded(
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    labelPadding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    labelColor: AppColors.white,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: const DotIndicator(),
                    tabs: [
                      Tab(
                        text: libraryCollections[0],
                      ),
                    ]),
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: [
                  LibraryTabView(
                      userId: user.id,
                      libraryCollection: libraryCollections[0],
                      fromSales: widget.fromSales,
                      fromStolen: widget.fromStolen,
                      accountType: user.accountType),
                ]),
              ),
            ]),
          );

          default:
          return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
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
      body: Column(children: [
        title,
        dropDown,
        tabs(),
        
      ]),
    );
  }
}
