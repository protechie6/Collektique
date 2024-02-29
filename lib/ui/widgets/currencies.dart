import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../models/currency_model.dart';
import '../../utils/all_constants.dart';
import 'text.dart';

class Currency extends StatefulWidget {
  const Currency({
    Key? key,
    required this.selectedCurrency,
  }) : super(key: key);

  final ValueChanged<String> selectedCurrency;

  @override
  State<Currency> createState() => CurrencyState();
}

class CurrencyState extends State<Currency> {
  
   ValueNotifier<String> view = ValueNotifier('');
    List<CurrencyModel> currency = AppConstants.currencies;

  @override
  void initState(){
    
    super.initState();
  }

 void selectCurrency() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select currency"),
        content: SizedBox(
          height: 200.0,
          child: ListView.builder(
              itemCount: currency.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 25.0, top: 5.0),
                  child: ValueListenableBuilder<String>(
                    valueListenable: view,
                    builder:
                        (BuildContext context, String value, Widget? child) {
                      return RadioListTile(
                        title: customText(currency[index].currency,
                                fontSize: 16,
                                textColor: AppColors.textColor,),
                        value: currency[index].iso,
                        groupValue: value,
                        activeColor: AppColors.textColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (value) {
                          view.value = value.toString();
                        },
                      );
                    },
                  ),
                );
              }),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.buttonColor1,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.selectedCurrency(view.value);
              Navigator.pop(context,);
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Done",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top:5.0,
        left: 20,
        right: 20,
        ),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Click ', 
            style: textStyle(color: AppColors.white,fontSize: 16.0),),
            TextSpan(
              text: 'here ', 
            style: textStyle(color: AppColors.buttonColor1,fontSize: 16.0),
            recognizer: TapGestureRecognizer()
                ..onTap = (){
                selectCurrency();
                },
                ),
            TextSpan(
              text: 'to change the currency.',
              style: textStyle(color: AppColors.white,fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
