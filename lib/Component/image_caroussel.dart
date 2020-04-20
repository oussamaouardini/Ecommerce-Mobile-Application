import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';

List imageCarouselList = [
  Image.asset("images/img.jpg"),
  Image.asset("images/imageleft.jpg"),
  Image.asset("images/imgright.jpg"),
  Image.asset("images/imgvid1.jpg"),
  Image.asset("images/imgvid2.jpg"),
];

Widget imageCarousel = new Container(
  height: 200.0,
  child: Carousel(
    boxFit: BoxFit.cover,
    autoplay: false,
    animationCurve: Curves.easeIn,
    animationDuration: Duration(milliseconds: 500),
    dotSize: 6.0,
    dotIncreasedColor: Color(0xFF01B2C4),
    dotBgColor: Colors.transparent,
    showIndicator: true,
    indicatorBgPadding: 7.0,
    images: imageCarouselList,
  ),
);
