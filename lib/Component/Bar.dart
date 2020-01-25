import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Bar extends StatefulWidget {
  final first ;
  final second ;
  final third ;
  final firstIcon;
  final secondIcon;
  final thirdIcon;
  final pageController ;
  Bar({this.first,this.second,this.third,this.firstIcon,this.secondIcon,this.thirdIcon,this.pageController});
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  var  currentpage = 0 ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CubertoBottomBar(
        barBackgroundColor: Color(0xFF01B2C4),
        inactiveIconColor: Colors.white,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND, // By default its CubertoTabStyle.STYLE_NORMAL
        selectedTab: currentpage, // By default its 0, Current page which is fetched when a tab is clickd, should be set here so as the change the tabs, and the same can be done if willing to programmatically change the tab.
        //drawer: CubertoDrawer.NO_DRAWER, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
        tabs: [
          TabData(
            iconData: widget.firstIcon,
            title: widget.first,
            tabColor: Colors.white,
          ),
          TabData(
           // iconData: FontAwesomeIcons.female,
            iconData: widget.secondIcon,
            title: widget.second,
            tabColor: Colors.white,
          ),
          TabData(
            iconData: widget.thirdIcon,
            title: widget.third,
            tabColor: Colors.white,
          ),
        ],
        onTabChangedListener: (position, title, color) {
          setState(() {
            currentpage = position ;
            widget.pageController.animateToPage(position, duration: kTabScrollDuration, curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}






