import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageProvider extends ChangeNotifier {
  var locale = const Locale('en', 'US');
  var languageCode = 'en';

  void toggleLanguage() {
    languageCode = locale.languageCode;

    if (languageCode == 'en') {
      locale = const Locale('abc', 'far');
      Get.updateLocale(locale);
      notifyListeners();
      languageCode = languageCode == 'en' ? 'abc' : 'en';

    } else if (languageCode == 'abc') {
      locale = const Locale('en', 'US');
      Get.updateLocale(locale);
      notifyListeners();
      languageCode = languageCode == 'en' ? 'abc' : 'en';

    } else {
      locale = const Locale('en', 'US');
      Get.updateLocale(locale);
      notifyListeners();
      languageCode = 'en';

    }

  }
}
