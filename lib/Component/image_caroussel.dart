import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


List imageCarousselList = [
  AssetImage('images/c1.jpg'),
  AssetImage('images/IMG_1266.JPG'),
  AssetImage('images/m2.jpg'),
  AssetImage('images/m1.jpeg'),
  AssetImage('images/w1.jpeg'),
  AssetImage('images/w3.jpeg'),
  AssetImage('images/w4.jpeg'),
];

Widget ImageCarousel = new Container(
  height: 200.0,
  child: Carousel(
    boxFit: BoxFit.cover,
    autoplay: false,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 500),
    dotSize: 6.0,
    dotIncreasedColor: Color(0xFF01B2C4),
    dotBgColor: Colors.transparent,
    showIndicator: true,
    indicatorBgPadding: 7.0,
    images: imageCarousselList,
  ),
);