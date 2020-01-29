import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';


List imageCarousselList = [
  Image.network('https://www.decathlon.in/content/opeco-2020/fit-utsav-w4-2020/images/nFitness-Landing-page-Main-BAnner.jpg'),
  Image.network('https://www.decathlon.in/content/opeco-2020/runninglp-w5-2020/images/Running-Landing-page-Main-banner.jpg'),
  Image.network('https://www.decathlon.in/content/opeco-2019/snowhiking-lp-w49-50-2019/images/Hiking-panoply-Main-Banner.jpg'),
  Image.network('https://www.decathlon.in/content/opeco-2019/winter-opeco-upd-2019/images/Winter-OPECO-Landing-Page-Investment-Products.jpg'),
  Image.network('https://www.decathlon.in/content/opeco-2019/winter-opeco-upd-2019/images/desk/Winter-OPECO-Landing-Page-HB-2.jpg'),
  Image.network('https://www.decathlon.in/content/opeco-2019/winter-opeco-upd-2019/images/desk/Winter-OPECO-Landing-Page-Clearance-sale.jpg'),
];

Widget ImageCarousel = new Container(
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
    images: imageCarousselList,
  ),
);