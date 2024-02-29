import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/currency_model.dart';
import '../../../utils/all_constants.dart';
import '../../../utils/shared_preference.dart';
import '../../widgets/text.dart';

class CurrencyPreference extends StatefulWidget {
  const CurrencyPreference({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CurrencyPreferenceState();
}

class CurrencyPreferenceState extends State<CurrencyPreference> {
  late ValueNotifier<String> view;
  List<CurrencyModel> currency = AppConstants.currencies;

  @override
  void initState() {
    String defaultCurrency =
        SharedPrefs.getString('default currency') ?? 'EUR';
    view.value = defaultCurrency;
    super.initState();
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: ValueListenableBuilder<String>(
        valueListenable: view,
        builder: (BuildContext context, String value, Widget? child) {
          return RadioListTile(
            title: customText(
              currency[index].currency,
              fontSize: 16,
              textColor: AppColors.textColor,
            ),
            value: currency[index].iso,
            groupValue: value,
            activeColor: AppColors.textColor,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (value) {
              view.value = value.toString();
              SharedPrefs.setString(AppConstants.defaultCurrency, value.toString());
            },
          );
        },
      ),
    );
  }

  Widget body() {
    return ListView.builder(
        itemCount: currency.length, itemBuilder: itemBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText("Currency", fontSize: 15.0),
        elevation: 0,
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
      ),
      body: body(),
    );
  }
}
