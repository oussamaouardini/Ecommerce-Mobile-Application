import 'package:flutter/material.dart';
import 'package:pfe/Screens/Account.dart';

import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/shoping_cart.dart';
import 'package:pfe/Screens/favorite_screen.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/cart/cart.dart' as cart;




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
        CartApi cartApi = CartApi() ;
        cart.Cart car = await  cartApi.fetchCart();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart(car.total)));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new Account()));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomeScreen()));
    }

  }


}