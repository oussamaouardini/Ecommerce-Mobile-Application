import 'package:flutter/material.dart';
import 'package:pfe/Screens/Account.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/shoping_cart.dart';
import 'package:pfe/Screens/favorite_screen.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:pfe/customer/user.dart';
import 'package:pfe/user/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/cart/cart.dart' as cart;

class Functions {
  static void routeBottomBar(int i, BuildContext context) async {
    switch (i) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new HomeScreen()));
        break;
      case 1:
        SharedPreferences pref = await SharedPreferences.getInstance();
        int userId = pref.getInt('user_id');
        String apiToken = pref.getString('api_token');
        if ((userId != null) || (apiToken != null)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new Favorite(
                        userId: userId,
                      )));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Alert();
              });
        }

        break;
      case 2:
        CartApi cartApi = CartApi();

        SharedPreferences pref = await SharedPreferences.getInstance();
        int userId = pref.getInt('user_id');
        String apiToken = pref.getString('api_token');
        if ((userId != null) || (apiToken != null)) {
          cart.Cart car = await cartApi.fetchCart();
          if(car == null){
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(msg:"your Shopping card is empty");
                });
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new Cart(car.total)));
          }
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Alert();
              });
        }

        break;
      case 3:
        UserApi userApi = UserApi();
        SharedPreferences pref =
        await SharedPreferences.getInstance();
        int userId = pref.getInt('user_id');
        String apiToken = pref.getString('api_token');
        if ((userId != null) || (apiToken != null)) {
          User user = await userApi.fetchUser(userId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  new Account(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    email: user.email,
                    password: user.password,
                    memberSince: user.memberSince,
                    mobile: user.mobile,
                    shippingAddress: user.shippingAddress,
                  )));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Alert();
              });
        }

        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new HomeScreen()));
    }
  }
}


class Dialog extends StatelessWidget {
  final String msg ;
  const Dialog({
    Key key,
    this.msg
  }) ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(" Welcome"),
      content: SizedBox(
        height: 40.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${this.msg.toString()}?'),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          child: Text('Close'),
        )
      ],
    );
  }
}