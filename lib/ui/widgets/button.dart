import 'package:flutter/material.dart';

import '../../utils/all_constants.dart';

Widget customButton({
  required void Function()? function, double elevation=3,
 double buttonWidth=250.0, Color? backgroundColor, Widget? child, double buttonHeight=45.0,}){

  return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor??AppColors.buttonColor1,
          foregroundColor: Colors.white,
          elevation: elevation,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          minimumSize: Size(buttonWidth, buttonHeight), //////// HERE
        ),
        onPressed: function,
        child: child,
      );
}