import 'package:flutter/material.dart';
import 'package:pfe/Screens/Account.dart';

import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/shoping_cart.dart';
import 'package:pfe/Screens/favorite_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class functions{

  static void  route_bottom_bar(int i,BuildContext context) async{
    switch (i) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomeScreen()));
        break;
      case 1:
        //
        break;
      case 2:
        SharedPreferences pref = await SharedPreferences.getInstance();
        int user_id =  pref.getInt('user_id');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Favorite(user_id: user_id,)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Account()));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomeScreen()));
    }

  }


}