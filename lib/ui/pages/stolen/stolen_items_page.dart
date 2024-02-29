
import 'package:flutter/material.dart';
import 'package:watch_vault/ui/pages/stolen/tabs/stolen_items_gridview.dart';
import 'package:watch_vault/ui/pages/stolen/tabs/stolen_items_listview.dart';
import 'package:watch_vault/utils/all_constants.dart';
import 'package:watch_vault/database_collection/stolen_database.dart';
import 'package:watch_vault/ui/widgets/custom_floating_button.dart';


class StolenItems extends StatefulWidget {
  const StolenItems({Key? key}) : super(key: key);

  @override
  State<StolenItems> createState() => StolenItemsState();
}

class StolenItemsState extends State<StolenItems>
    with TickerProviderStateMixin {
  //ValueNotifier<String> ui = ValueNotifier("grid");

  Stream? stream;
  late TabController _controller;
  bool isOpened = false;

  @override
  void dispose() {
   // ui.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    stream = StolenWatchDatabase().stolenWatchData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget row1 = Container(
      margin: const EdgeInsets.only(
        top: 0,
        bottom: 10,
        left: 20.0,
      ),
      child: const Text(
        "Stolen",
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Poppins',
            fontSize: 20,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
    );

    Widget searchBox = Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        right: 20.0,
        left: 20.0,
        bottom: 10.0,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontSize: 15.0, color: AppColors.textColor, fontFamily: 'Poppins'),
        decoration: const InputDecoration(
            hintText: "search by serial number",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: AppColors.textColor,
            ),
            filled: true,
            fillColor: AppColors.white,
            prefixIcon: ImageIcon(
              AssetImage("assets/images/search.png"),
              color: AppColors.textColor,
            )),
        onChanged: (value) {
          setState(() {
            stream = StolenWatchDatabase()
                .queryStolenWatchDatabase("brand", value.toString());
          });
        },
      ),
    );

    Widget tabs = Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
          controller: _controller,
          isScrollable: true,
          labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
          indicatorColor: Colors.transparent,
          labelColor: AppColors.white,
          unselectedLabelColor: Colors.blueGrey,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.grid_view_outlined,
                size: 18.0,
              ),
              text: "Grid",
            ),
            Tab(
              icon: Icon(
                Icons.view_list,
                size: 18.0,
              ),
              text: "List",
            ),
          ]),
    );

    Widget tabBarView = Expanded(
        child: TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: const [
        StolenItemGridView(),
        StolenItemListView(),
      ],
    ));

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
      body: Opacity(
            opacity: isOpened? 0.2: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                row1,
                searchBox,
                tabs,
                tabBarView,
              ],
            ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingButton(isOpened: (bool value) { 
        setState(()=>isOpened = value);
      },),
    );
  }
}
