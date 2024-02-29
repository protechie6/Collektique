import 'package:flutter/material.dart';

import '../../utils/all_constants.dart';

class WatchBrands extends StatefulWidget {
  const WatchBrands({
    Key? key,
    required this.selectedBrand,
    this.initialValue,
  }) : super(key: key);

  final ValueChanged<String> selectedBrand;
  final String? initialValue;

  @override
  State<WatchBrands> createState() => WatchBrandsState();
}

class WatchBrandsState extends State<WatchBrands> {
  
  late String dropdownvalue;

  @override
  void initState(){
    if(widget.initialValue == null){
      dropdownvalue = "";
    }else{
      dropdownvalue = widget.initialValue!;
    }
    super.initState();
  }

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
        items: AppConstants.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
                style: const TextStyle(
                    color: Color.fromRGBO(32, 72, 72, 1),
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
          setState(() {
            dropdownvalue = newValue!;
            widget.selectedBrand(dropdownvalue);
          });
        },
      ),
    );
  }
}
