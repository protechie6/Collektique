import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/all_constants.dart';

Widget customText(String text,{required double fontSize, Color? textColor, TextAlign? textAlign, int? maxLines,
 TextOverflow? overflow, FontWeight? fontWeight}){
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign?? TextAlign.center,
    style: textStyle(fontSize:fontSize,color: textColor, fontWeight: fontWeight),
  );
}

TextStyle textStyle({double fontSize=12.0, Color? color,FontWeight? fontWeight}){
  return TextStyle(
                fontFamily: 'Poppins',
                letterSpacing:0,
                fontWeight: fontWeight??FontWeight.normal,
                  fontSize: fontSize,
                  color: color??AppColors.white,
                height: 1.5,
                );
}

Widget bulletin({required String textSpan0, required String textSpan1, double fontSize0=18.0, double fontSize1=18.0, 
Color? color, FontWeight? fontWeight0, FontWeight? fontWeight1}){
  return RichText(

        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: textSpan0, 
            style: textStyle(color: AppColors.white,fontSize: fontSize0, fontWeight: fontWeight0),),
            TextSpan(
              text: textSpan1, 
            style: textStyle(color: AppColors.white,fontSize: fontSize1, fontWeight: fontWeight1),
                ),
          ],
        ),
      );
}