import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  int pageIndex = 1;
  final PageController pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;

    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Center(
                  child: Lottie.asset('assets/images/anim_lottie/anim_bg_developer.json', height: height * .33, width: width - 20, fit: BoxFit.fill),
                ),

                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.40,
                          child: ElevatedButton(
                            onPressed: () {
                              pageViewController.previousPage(duration: const Duration(milliseconds: 700), curve: Curves.easeIn);

                              setState(() {
                                pageIndex = 1;
                              });
                            },
                            style: pageIndex == 1
                                ? ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent)
                                : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            child: const Text(
                              "Ability",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.40,
                          child: ElevatedButton(
                            onPressed: () {
                              pageViewController.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.easeIn);
                              pageIndex = 2;
                              setState(() {
                                pageIndex = 2;
                              });
                            },
                            style: pageIndex == 2
                                ? ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent)
                                : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            child: const Text(
                              "About App",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// choice chip
                SizedBox(
                  height: (height * 0.66) - (padding.top + padding.bottom) - (height * 0.15),
                  width: width,
                  child: PageView(
                    controller: pageViewController,
                    onPageChanged: (value) {
                      if (value == 0) {
                        setState(() {
                          pageIndex = 1;
                        });
                      }
                      if (value == 1) {
                        setState(() {
                          pageIndex = 2;
                        });
                      }
                    },
                    children: [
                      widgetSkills(textTheme),
                      widgetAboutApp(textTheme),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetSkills(TextTheme textTheme) {
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'about_me_core_programming_skills'.tr,
                  style: textTheme.bodyLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                expandedAlignment: Alignment.center,
                trailing: const Icon(
                  size: 28,
                  Icons.add_circle_outline_sharp,
                  color: Colors.green,
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'about_me_core_programming_skills_1'.tr,
                        style: textTheme.bodyMedium,
                        textDirection: TextDirection.ltr,
                      ),
                      Text(
                        'about_me_core_programming_skills_2'.tr,
                        style: textTheme.bodyMedium,
                        textDirection: TextDirection.ltr,
                      ),
                      Text(
                        'about_me_core_programming_skills_3'.tr,
                        style: textTheme.bodyMedium,
                        textDirection: TextDirection.ltr,
                      ),
                      Text(
                        'about_me_core_programming_skills_4'.tr,
                        style: textTheme.bodyMedium,
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'about_me_flutter_framework_knowledge'.tr,
                  style: textTheme.bodyLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                trailing: const Icon(
                  size: 28,
                  Icons.add_circle_outline_sharp,
                  color: Colors.green,
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'about_me_flutter_framework_knowledge_1'.tr,
                        style: textTheme.bodyMedium,
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: false,
                title: Text(
                  'about_me_knowledge_lifecycle'.tr,
                  style: textTheme.displayLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                trailing: SizedBox(
                  height: 45,
                  width: 45,
                  child: Lottie.asset('assets/images/anim_lottie/anim_tick.json', height: 45, width: 45, fit: BoxFit.fill, repeat: false),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: false,
                title: Text(
                  'about_me_ci_cd'.tr,
                  style: textTheme.displayLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                trailing: SizedBox(
                  height: 45,
                  width: 45,
                  child: Lottie.asset('assets/images/anim_lottie/anim_tick.json', height: 45, width: 45, fit: BoxFit.fill, repeat: false),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: false,
                title: Text(
                  'about_me_solving'.tr,
                  style: textTheme.displayLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                trailing: SizedBox(
                  height: 45,
                  width: 45,
                  child: Lottie.asset('assets/images/anim_lottie/anim_tick.json', height: 45, width: 45, fit: BoxFit.fill, repeat: false),
                ),
                //   Lottie.asset('images/anim_tick.json', height: 20, width: 20, fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: false,
                title: Text(
                  'about_me_communication'.tr,
                  style: textTheme.displayLarge,
                  textDirection: TextDirection.ltr,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                trailing: SizedBox(
                  height: 45,
                  width: 45,
                  child: Lottie.asset('assets/images/anim_lottie/anim_tick.json', height: 45, width: 45, fit: BoxFit.fill, repeat: false),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget widgetAboutApp(TextTheme textTheme) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    'dependencies'.tr,
                    style: textTheme.bodyLarge,
                    textDirection: TextDirection.ltr,
                  ),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  expandedAlignment: Alignment.center,
                  trailing: const Icon(
                    size: 28,
                    Icons.local_fire_department,
                    color: Colors.amberAccent,
                  ),
                  children: [
                    Column(
                      children: [
                        Text(
                          'list_dependencies'.tr,
                          style: textTheme.bodyMedium,
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
