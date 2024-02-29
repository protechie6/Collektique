import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:watch_vault/utils/all_constants.dart';

class TextSwitchToggle extends StatefulWidget {
  const TextSwitchToggle({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final ValueChanged<String> selected;

  @override
  State<StatefulWidget> createState() => TextSwitchToggleState();
}

class TextSwitchToggleState extends State<TextSwitchToggle> {
  int initialValue = 1;

  @override
  Widget build(BuildContext context) {

    double buttonWidth = (MediaQuery.of(context).size.width)/3.0;

    return ToggleSwitch(
      minWidth: buttonWidth,
      minHeight: 45.0,
      fontSize: 14.0,
      initialLabelIndex: initialValue,
      activeBgColor: const [AppColors.white],
      activeFgColor: AppColors.backgroundColor,
      inactiveBgColor: AppColors.backgroundColor,
      inactiveFgColor: AppColors.white,
      totalSwitches: 2,
      labels: const [
        'Yes',
        'No',
      ],
      onToggle: (index) {
        if(index==0){
          setState(() {
          widget.selected('Yes');
          initialValue = index!;
        });
        }else{
          setState(() {
          widget.selected('No');
          initialValue = index!;
        });
        }
      },
    );
  }
}
