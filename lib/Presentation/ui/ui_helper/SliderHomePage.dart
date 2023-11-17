
import 'package:flutter/material.dart';

class SliderHomePage extends StatefulWidget {
  var controller;

  SliderHomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SliderHomePage> createState() => _SliderHomePageState();
}

class _SliderHomePageState extends State<SliderHomePage> {
  var images = [
    'assets/images/img_slider_one.png',
    'assets/images/a2.png',
    'assets/images/a3.png',
    'assets/images/a4.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: true,
      controller: widget.controller,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }

  Widget myPages(String image) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ));
  }
}
