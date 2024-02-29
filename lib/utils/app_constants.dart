import '../models/currency_model.dart';

class AppConstants {
  static const appName = "Collektique";
  static const email = "email";
  static const password = "password";
  static const rememberMe = "rememberMe";
  static const isFirstTime = "isFirstTime";
  static const defaultCurrency = 'EUR';
  static const fingerPrint = "fingerPrint";
  static const basic = "BASIC";
  static const pro = "PRO";
  static const platinum = "PLATINUM";
  static const image = "image";
  static const text = "text";
  static const shoe = "Shoes";
  static const watch = "Watches";
  static const bag = "Bags";
  static const car = "Cars";
  static const String branchIoDeepLink = "Generate Branch IO Deep Link";
  static const String deepLinkTitle = "deep_link_title";
  static const String clickedBranchLink = "+clicked_branch_link";
  static const String controlParamsKey = '\$uri_redirect_mode';
  static const String deepLinkData = 'flutter deep link';
  static const String branchIoCanonicalIdentifier = 'flutter/branch';
  static const String gettingData = "Getting Data";

  static List<CurrencyModel> currencies = [
    CurrencyModel(currency: 'Australian dollar', iso: 'AUD'),
    CurrencyModel(currency: 'Canadian dollar', iso: 'CAD'),
    CurrencyModel(currency: 'Chinese renminbi', iso: 'CNH'),
    CurrencyModel(currency: 'Euro', iso: 'EUR'),
    CurrencyModel(currency: 'Hong kong dollar', iso: 'HKD'),
    CurrencyModel(currency: 'Japanese yen', iso: 'JPY'),
    CurrencyModel(currency: 'New zealand dollar', iso: 'NZD'),
    CurrencyModel(currency: 'Pound sterling', iso: 'GBP'),
    CurrencyModel(currency: 'Swiss franc', iso: 'CHF'),
    CurrencyModel(currency: 'US dollar', iso: 'ÚSD'),
  ];

  // List of items in our dropdown menu
  static List<String> items = [
    "",
    "A.Lange & Söhne",
    "Alpina",
    "Armani",
    "Arnold & Son",
    "Audemars Piguet",
    "Bamford",
    "Baume & Mercier",
    "Bell & Ross",
    "Blancpain",
    "Breitling",
    "Bremont",
    "Bulgari",
    "Bulova",
    "Bovet Fleurier",
    "Cartier",
    "Chopard",
    "Digital watches",
    "F.P.Journe",
    "Girard-Perregaux",
    "Gucci",
    "Hamilton",
    "Hublot",
    "IWC Schaffhausen",
    "Jaeger-LeCoultre",
    "Jaquet Droz",
    "Junghans",
    "Laurent Ferrier",
    "LIV Watches",
    "Longines",
    "Louis Vuitton",
    "Maurice de Mauriac",
    "Maurice Lacroix",
    "Montblanc",
    "NOMOS Glashütte",
    "Nordgreen",
    "Omega",
    "Oris",
    "Panerai",
    "Parmigiani Fleurier",
    "Patek Philippe",
    "Piaget",
    "Rado",
    "Roger Dubuis",
    "Rolex",
    "Seiko",
    "TAG Heuer",
    "Tiffany & Co.",
    "Tissot",
    "Tudor",
    "Ulysse Nardin",
    "Vacheron Constantin",
    "Van Cleef & Arpels",
    "Vincero",
    "Weiss",
    "Zenith",
  ];
}
