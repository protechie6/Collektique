import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';
import '../transaction/transactions.dart';
import 'currency_preference.dart';
import 'inbox/inbox.dart';
import 'insurance_details.dart';
import 'recently_searched.dart';
import 'saved items/saved_item.dart';
import 'security/account_security.dart';
import 'upgrade/account_upgrade.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget textsection1 = Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: customText(
        AppConstants.appName,
        textAlign: TextAlign.left,fontSize:15.0
      ),
    );

    Widget upgradeAccountButton = Container(
      
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AccountUpgrade()));
        },
        child:  Row(
          children: [
            const ImageIcon(
              AssetImage("assets/images/upgrade_account.png"),
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Upgrade Account",fontSize:15.0
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget inboxButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Inbox()));
        },
        child:  Row(
          children: [
            const ImageIcon(
              AssetImage("assets/images/inbox.png"),
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Inbox",fontSize:15.0
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget currencyButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CurrencyPreference()));
        },
        child:  Row(
          children: [
            const Icon(
              Icons.money,
              size: 18.0,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Currency",fontSize:15.0
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget recentlySearchedButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RecentlySearched()));
        },
        child:  Row(
          children: [
            const Icon(
              Icons.youtube_searched_for,
              size: 18.0,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Recently Searched",
              fontSize:15.0,
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget savedItemsButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SavedItem()));
        },
        child:  Row(
          children: [
            const Icon(
              Icons.favorite,
              size: 18.0,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Saved Items",fontSize:15.0), // <-- Text
            const Spacer(),
           const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget securityButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AccountSecurity()));
        },
        child: Row(
          children: [
            const Icon(
              // <-- Icon
              Icons.security,
              size: 18.0,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Security",fontSize:15.0), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget transactionButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Transaction()));
        },
        child:  Row(
          children: [
            const ImageIcon(
            AssetImage("assets/images/payments.png"),
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Transactions",
              fontSize:15.0,
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    Widget insuranceDetailsButton = Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: customButton(
        elevation:0.0,
        backgroundColor: AppColors.backgroundColor,
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InsuranceDetails()));
        },
        child:  Row(
          children: [
            const Icon(
              // <-- Icon
              Icons.contact_page,
              size: 18.0,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            customText(
              "Insurance details",
              fontSize:15.0,
            ), // <-- Text
            const Spacer(),
            const Icon(
              // <-- Icon
              Icons.arrow_forward_ios,
              size: 18.0,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          "Account",
          fontSize:15.0),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textsection1,
            currencyButton,
            inboxButton,
            insuranceDetailsButton,
            recentlySearchedButton,
            savedItemsButton,
            securityButton,
            transactionButton,
            upgradeAccountButton,
          ],
        ),
      ),
    );
  }
}
