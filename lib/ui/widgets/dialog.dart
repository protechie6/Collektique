import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:watch_vault/utils/all_constants.dart';

class LoadingDialog extends StatelessWidget{
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: AppColors.backgroundColor,
      child: const Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
          ),
      ),
    );
  }
}