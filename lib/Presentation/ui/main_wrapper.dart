import 'dart:io';

import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:exchange/Presentation/ui/pages/home_page.dart';
import 'package:exchange/Presentation/ui/pages/searchable_market_page.dart';
import 'package:exchange/Presentation/ui/pages/signup_page.dart';
import 'package:exchange/Presentation/ui/pages/about_me_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int index = 0;
  final PageController _mainWrapperPageController = PageController(initialPage: 0);

  DateTime timeBackPress = DateTime.now();



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
          //todo floating action button
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: const Icon(Icons.compare_arrows_outlined),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          //todo bottom navigation
          // bottomNavigationBar: BottomNav(
          //   controller: _mainWrapperPageController,
          // ),


          drawer: CurvedDrawer(
            index: index,
            color: const Color.fromARGB(255, 255, 240, 219),
            buttonBackgroundColor: Colors.lightGreenAccent,
            labelColor: Colors.red,
            backgroundColor: Colors.transparent,
            width: 70.0,
            animationCurve: Curves.bounceOut,
            animationDuration: const Duration(seconds: 1),
            items: const <DrawerItem>[
              DrawerItem(icon: Icon(Icons.home), label: "Home"),
              DrawerItem(icon: Icon(Icons.currency_bitcoin), label: "Market"),
              DrawerItem(icon: Icon(Icons.person), label: "Sign up"),
              DrawerItem(icon: Icon(Icons.phone), label: "Contact")
            ],
            onTap: (newIndex) {
              _mainWrapperPageController.jumpToPage(newIndex);
              setState(
                () {
                  index = newIndex;
                },
              );
            },
          ),

          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _mainWrapperPageController,
            children: const [HomePage(), MarketViewPage(), SignUpScreen(), WatchListPage()],
          ),
        ),
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPress);

          final isExitWarning = difference >= const Duration(seconds: 2);
          timeBackPress = DateTime.now();

          if (isExitWarning) {
            Get.snackbar(
              'Exit',
              'press back again to exit...',
              duration: const Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.exit_to_app, color: Colors.deepOrange),
              backgroundColor: const Color(0xff838996),
            );

            return false;
          } else {
            exit(0);
            return true;
          }
        });
  }
}
