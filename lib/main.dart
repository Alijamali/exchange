import 'dart:async';

import 'package:exchange/Logic/provider/crypto_data_provider.dart';
import 'package:exchange/Logic/provider/language_provider.dart';
import 'package:exchange/Logic/utils/MyThemes.dart';
import 'package:exchange/Logic/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'Logic/provider/all_crypto_data_provider.dart';
import 'Logic/provider/user_data_provider.dart';
import 'Presentation/ui/main_wrapper.dart';
import 'package:get/get.dart';

import 'Translations/Messages.dart';

void main() {
  // for portrait screen
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CryptoDataProvider()),
        ChangeNotifierProvider(create: (context) => ChangeLanguageProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => AllCryptoDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    Timer(const Duration(seconds: 4), () => Get.to(const MainWrapper()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return GetMaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        debugShowCheckedModeBanner: false,

        translations: Messages(),
        // your translations
        locale: const Locale('en', 'US'),
        // translations will be displayed in that locale
        // fallbackLocale: Locale('fa', ''),// specify the fallback locale in case an invalid locale is selected.

        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset('assets/images/anim_lottie/anim_splash.json',
                    height: MediaQuery.of(context).size.width, width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
              ),
            ),
          ),
        ),
      );
    });
  }
}
