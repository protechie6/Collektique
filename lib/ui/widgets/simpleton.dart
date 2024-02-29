import 'package:flutter/material.dart';
import '../../utils/all_constants.dart';

Widget shimmer({required double height, required double width}){
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:AppColors.white.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(16.0))
      ),
    );
  }