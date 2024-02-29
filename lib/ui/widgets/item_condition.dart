import 'package:flutter/material.dart';

class ItemCondition extends StatefulWidget {
  const ItemCondition({
    Key? key,
    required this.selectedConditon,
  }) : super(key: key);

  final ValueChanged<String> selectedConditon;

  @override
  State<StatefulWidget> createState() => ItemConditionState();
}

class ItemConditionState extends State<ItemCondition> {
  
  String dropdownvalue = "Add details";
// List of items in our dropdown menu
  var items = [
    "Add details",
    "Good",
    "Fair",
    "Poor",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,
        underline: Container(),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Color.fromRGBO(32, 72, 72, 1)),
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
                    color: Color.fromRGBO(32, 72, 72, 1),
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1)),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            widget.selectedConditon(dropdownvalue);
          });
        },
      ),
    );
  }
}
