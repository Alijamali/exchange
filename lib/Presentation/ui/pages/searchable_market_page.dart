import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shimmer/shimmer.dart';

import 'package:exchange/Data/models/CryptoData.dart';
import 'package:exchange/Data/models/ResponseModel.dart';
import 'package:exchange/Logic/provider/language_provider.dart';
import 'package:exchange/Presentation/utils/DecimalRounder.dart';

import 'package:exchange/Logic/provider/all_crypto_data_provider.dart';

class MarketViewPage extends StatelessWidget {
  const MarketViewPage({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<ChangeLanguageProvider>(context);

    late TextTheme textTheme = Theme.of(context).textTheme;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<AllCryptoDataProvider>(context).getAllMarketCapData();
      //context.read<AllCryptoDataProvider>().getAllMarketCapData();

      // Provider.of<CryptoDataProvider>(context).getAllMarketCapData();
    });


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                /// show data from api
                Expanded(
                  child: Consumer<AllCryptoDataProvider>(builder: (contextCon, cryptoDataProvider, child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: SizedBox(
                            height: 100,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
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
                                                      width: 70,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: SizedBox(
                                                        width: 30,
                                                        height: 15,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
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
                                                height: 35,
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
                                                      width: 65,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: SizedBox(
                                                        width: 30,
                                                        height: 15,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
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
                                        ),
                                        const Divider(
                                          color: Colors.amberAccent,
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: 20,
                                )),
                          ),
                        );

                      case Status.COMPLETED:
                        List<CryptoData> searchResult = cryptoDataProvider.dataFuture.data!.cryptoCurrencyList!;

                        print("==============> ${searchResult.length} ");
                        return renderSimpleSearchableList(languageProvider, searchResult, textTheme);
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

  Widget renderSimpleSearchableList(ChangeLanguageProvider languageProvider, List<CryptoData> searchResult, TextTheme textTheme) {
    return SearchableList<CryptoData>(
      seperatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Divider(
            color: Colors.amberAccent,
          ),
        );
      },

      style: textTheme.bodySmall,

      builder: (list, index, item) {
        var number = index + 1;
        var tokenId = item.id;

        MaterialColor filterColor = DecimalRounder.setColorFilter(searchResult[index].quotes![0].percentChange24h);

        var finalPrice = DecimalRounder.removePriceDecimals(searchResult[index].quotes![0].price);

        // percent change setup decimals and colors
        var percentChange = DecimalRounder.removePercentDecimals(searchResult[index].quotes![0].percentChange24h);

        Color percentColor = DecimalRounder.setPercentChangesColor(searchResult[index].quotes![0].percentChange24h);
        Icon percentIcon = DecimalRounder.setPercentChangesIcon(searchResult[index].quotes![0].percentChange24h);

        return SizedBox(
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
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      searchResult[index].symbol!,
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
        );
      },

      errorWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Error while fetching Coin',
            style: textTheme.bodySmall,
          )
        ],
      ),
      initialList: searchResult,
      filter: (p0) {
        return searchResult.where((element) => element.name.toString().toLowerCase().contains(p0.toString().toLowerCase())).toList();
      },
      reverse: false,
      emptyWidget: Text(
        'Empty',
        style: textTheme.bodySmall,
      ),
      onRefresh: () async {},
      cursorColor: textTheme.bodySmall?.color,

      onItemSelected: (CryptoData item) {
        Get.snackbar(
          '${item.name}',
          ' Rank is ${item.cmcRank} ',
          icon: const Icon(Icons.currency_bitcoin, color: Colors.orangeAccent),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xff838996),
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 1),
        );
      },

      autoFocusOnSearch: false,
      inputDecoration: InputDecoration(
        hintStyle: textTheme.bodySmall,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amberAccent, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: "   Search Coin   ",
        labelStyle: textTheme.bodySmall,
        fillColor: textTheme.bodySmall?.color,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.amberAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.amberAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      // secondaryWidget: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   child: Container(
      //     color: Colors.grey[400],
      //     child: const Padding(
      //       padding: EdgeInsets.symmetric(
      //         vertical: 20,
      //         horizontal: 10,
      //       ),
      //       child: Center(
      //         child: Icon(Icons.sort),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
