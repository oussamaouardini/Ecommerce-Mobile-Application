import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bar extends StatefulWidget {
  final first;
  final second;
  final third;

  final firstIcon;
  final secondIcon;
  final thirdIcon;
  final pageController;

  Bar(
      {this.first,
      this.second,
      this.third,
      this.firstIcon,
      this.secondIcon,
      this.thirdIcon,
      this.pageController});

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CubertoBottomBar(
        barBackgroundColor: Color(0xFFF9CA24),
        inactiveIconColor: Color(0XFF191919),
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        selectedTab: currentPage,
        tabs: [
          TabData(
            iconData: widget.firstIcon,
            title: widget.first,
            tabColor: Color(0XFF191919),
          ),
          TabData(
            iconData: widget.secondIcon,
            title: widget.second,
            tabColor: Color(0XFF191919),
          ),
          TabData(
            iconData: widget.thirdIcon,
            title: widget.third,
            tabColor: Color(0XFF191919),
          ),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            currentPage = position;
            widget.pageController.animateToPage(position,
                duration: kTabScrollDuration, curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
