import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../pages/library/my_library.dart';
import '../pages/stolen/upload_stolen_watch.dart';


class CustomFloatingButton extends StatefulWidget {
  

  const CustomFloatingButton({Key? key, required this.isOpened}) : super(key: key);

  final ValueChanged<bool> isOpened;

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: AppColors.buttonColor1,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    isOpened = !isOpened;
    widget.isOpened(isOpened);
    isOpened
        ? _animationController.forward()
        : _animationController.reverse();
    
  }

  Widget add() {
    return Row(
      mainAxisAlignment:MainAxisAlignment.end,
      children: [
       Visibility(
        visible:isOpened,child: 
        const Text("Upload from library", style: TextStyle(color: Colors.white,),)),
        const SizedBox(width: 12.0,),
       FloatingActionButton(
          backgroundColor: AppColors.buttonColor1,
          heroTag: null,
        onPressed: (){
          animate();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyLibrary(fromStolen: true,)),
          );
        },
        child: const Icon(Icons.collections),
      ),
      ] 
    );
  }

  Widget image() {
    return 
        Row(
          mainAxisAlignment:MainAxisAlignment.end,
      children: [
        Visibility(
          visible:isOpened,child: 
          const Text("New upload", style: TextStyle(color: Colors.white,),)),
        const SizedBox(width: 12.0,),
        FloatingActionButton(
          backgroundColor: AppColors.buttonColor1,
          heroTag: null,
        onPressed: (){
          animate();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadStolenWatch()),
          );},
        child: const Icon(Icons.upload),
      ),
      ] 
    );
  }

  Widget toggle() {
    return FloatingActionButton(
        heroTag: null,
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment:CrossAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value*3.3,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: image(),
        ),
            toggle(),
      ],
    );
  }
}