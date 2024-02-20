// import 'package:flutter/material.dart';
// import 'package:intl/locale.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const String englishLang = 'en';
// const String khmerLang = 'km';

// const String langCode = 'languageCode';

// Future<Locale> setLocale(String languageCode) async {
//   SharedPreferences _prerf = await SharedPreferences.getInstance();
//   await _prerf.setString('Lang_Code', '$languageCode');
//   return _locale(languageCode);
// }
// class AppConstants{
//   Locale _locale(String languageCode) {
//   Locale _temp;
//   switch (langCode) {
//     case englishLang:
//       _temp = Locale('$languageCode', 'US');
//       break;
//     case khmerLang:
//       _temp = Locale('$languageCode', 'KH');
//       break;
//     default:
//       _temp = Locale('$languageCode', 'KH');
//   }
//   return _temp;
// }
// }

