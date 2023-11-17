import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exchange/Logic/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:exchange/Data/models/CryptoData.dart';
import 'package:exchange/Data/models/ResponseModel.dart';
import 'package:exchange/Logic/provider/crypto_data_provider.dart';
import 'package:exchange/Presentation/utils/DecimalRounder.dart';
import 'package:exchange/Presentation/ui/ui_helper/SliderHomePage.dart';
import 'package:exchange/Presentation/ui/ui_helper/ThemeSwitcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageViewController = PageController(initialPage: 0);

  List<String> choicesList = ['top_market_caps', 'top_gainers', 'top_losers'];

  @override
  void initState() {
    // TODO: implement initState

    loadDrawerStatusShared();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<ChangeLanguageProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              languageProvider.toggleLanguage();
            },
            child: Text(
              languageProvider.languageCode == 'en' ? 'EN' : 'FA',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const ThemeSwitcher(),
        ],
        title: Text('crypto_market'.tr),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // banner slider
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 3, right: 3),
                  child: SizedBox(
                    height: height * 0.2,
                    width: width,
                    child: Stack(
                      children: [
                        SliderHomePage(controller: _pageViewController),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SmoothPageIndicator(
                              controller: _pageViewController,
                              count: 4,
                              effect: const ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                              ),
                              onDotClicked: (index) =>
                                  _pageViewController.animateToPage(index, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutQuint),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // text movable
                SizedBox(
                  height: height * 0.035,
                  width: width,
                  child: Marquee(
                    text: 'news'.tr,
                    style: textTheme.bodySmall,
                    textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                  ),
                ),

                SizedBox(
                  height: height * 0.002,
                ),

                // button buy and sell
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: Row(
                    textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              backgroundColor: Colors.green[700],
                            ),
                            child: Text('buy'.tr),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                backgroundColor: Colors.red[700]),
                            child: Text('sell'.tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// choice chip
                Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5),
                  child: SizedBox(
                    height: height * 0.06,
                    width: width,
                    child: Row(
                      textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                      children: [

                        Consumer<CryptoDataProvider>(builder:(context, cryptoDataProvider, child){
                          return  Wrap(
                            textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                            spacing: 8,
                            children: List.generate(choicesList.length, (index) {
                              return ChoiceChip(
                                  label: Text(choicesList[index].tr, style: textTheme.titleSmall),
                                  selected: cryptoDataProvider.defaultChoiceIndex == index,
                                  selectedColor: Colors.blue,
                                  onSelected: (value) {
                                    switch (index) {
                                      case 0:
                                        context.read<CryptoDataProvider>().getTopMarketCapData();
                                        print("=======> index :  $index ");
                                        // Provider.of<CryptoDataProvider>(contextCon , listen: false).getTopMarketCapData();
                                        break;
                                      case 1:
                                        context.read<CryptoDataProvider>().getTopGainersData();
                                        // Provider.of<CryptoDataProvider>(contextCon, listen: false).getTopGainersData();
                                        print("=======> index :  $index ");

                                        break;
                                      case 2:
                                        context.read<CryptoDataProvider>().getTopLosersData();
                                        // Provider.of<CryptoDataProvider>(contextCon, listen: false).getTopLosersData();
                                        print("=======> index :  $index ");

                                        break;
                                    }
                                  });
                            }),
                          );
                        }

                        )
                      ],
                    ),
                  ),
                ),

                /// show data from api
                SizedBox(
                  height: height * 0.5350,
                  child: Consumer<CryptoDataProvider>(builder: (contextCon, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 75,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.white,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Row(
                                    textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 22),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 80,
                                          height: 30,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: 10,
                              )),
                        );
                      case Status.COMPLETED:
                        List<CryptoData>? model = cryptoDataProvider.dataFuture.data!.cryptoCurrencyList;

                        // print(model![0].symbol);
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            var number = index + 1;
                            var tokenId = model?[index].id;

                            MaterialColor filterColor = DecimalRounder.setColorFilter(model?[index].quotes![0].percentChange24h);

                            var finalPrice = DecimalRounder.removePriceDecimals(model?[index].quotes![0].price);

                            // percent change setup decimals and colors
                            var percentChange = DecimalRounder.removePercentDecimals(model?[index].quotes![0].percentChange24h);

                            Color percentColor = DecimalRounder.setPercentChangesColor(model?[index].quotes![0].percentChange24h);
                            Icon percentIcon = DecimalRounder.setPercentChangesIcon(model?[index].quotes![0].percentChange24h);

                            return GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  '${model?[index].name}',
                                  ' Rank is ${model?[index].cmcRank} ',
                                  icon: const Icon(Icons.currency_bitcoin, color: Colors.orangeAccent),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: const Color(0xff838996),
                                  animationDuration: const Duration(seconds: 1),
                                  duration: const Duration(seconds: 1),
                                );
                              },
                              child: SizedBox(
                                height: 75,
                                child: Row(
                                  textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                      child: Text(
                                        number.toString(),
                                        style: textTheme.bodySmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                                      child: CachedNetworkImage(
                                          fadeInDuration: const Duration(milliseconds: 500),
                                          height: 32,
                                          width: 32,
                                          imageUrl: "https://s2.coinmarketcap.com/static/img/coins/128x128/$tokenId.png",
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) {
                                            return const Icon(Icons.error);
                                          }),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model![index].name!,
                                            style: textTheme.bodySmall,
                                          ),
                                          Text(
                                            model![index].symbol!,
                                            style: textTheme.labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(filterColor, BlendMode.srcATop),
                                          child: SvgPicture.network("https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "\$$finalPrice",
                                              style: textTheme.bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                percentIcon,
                                                Text(
                                                  "$percentChange%",
                                                  style: GoogleFonts.ubuntu(color: percentColor, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Divider(
                                color: Colors.amberAccent,
                              ),
                            );
                          },
                          itemCount: 10,
                        );
                      case Status.ERROR:
                        return Text(cryptoDataProvider.state.message);
                      default:
                        return Container();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadDrawerStatusShared() async {
    final prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool("open_drawer") ?? false;

    if (seen == false) {
      Future.delayed(const Duration(seconds: 2), () {
        Scaffold.of(context).openDrawer();
      });
      Future.delayed(const Duration(seconds: 5), () {
        Scaffold.of(context).closeDrawer();
      });
      prefs.setBool("open_drawer", true);
    }
  }
}
