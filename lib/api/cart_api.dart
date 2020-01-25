import 'package:http/http.dart' as http;
import 'package:pfe/api/api_util.dart';
import 'package:pfe/cart/cart.dart';
import 'dart:convert';

import 'package:pfe/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartApi {
  Map<String, String> _headers = {'Accept': 'application/json'};


  Future<Cart> fetchCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization':'Bearer '+apiToken
    };

    String url = ApiUtl.CART;

    http.Response response = await http.get(url, headers: _Authheaders);
    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
        return Cart.fromJson(body);
        break ;
      case 404 :
        throw ResourceNotFound('Cart');
        break ;
      case 301 :
      case 302 :
      case 303 :
        throw RedirectionFound();
        break ;
      default :
        return null;
        break ;
    }
  }



  Future<bool> addProductTocart(int  ProductID , int quantity) async{

    String url = ApiUtl.CART;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization':'Bearer '+apiToken
    };




    Map<String, dynamic > body = {
      'product_id': ProductID.toString(),
      'quantity': quantity.toString()
    };
    http.Response response = await http.post(url, headers: _Authheaders,body: body);

    switch(response.statusCode){
      case 200 :
      case 201 :
        var body = jsonDecode(response.body);
        return true ;
        break ;
      case 404 :
        throw ResourceNotFound('Categories');
        break ;
      case 301 :
      case 302 :
      case 303 :
        throw RedirectionFound();
        break ;
      default :
        return null;
        break ;
    }

  }

  Future<bool> RemoveProductFromCart(int  ProductID , int quantity) async{

    String url = ApiUtl.REMOVE_FROM_CART + '/'+ProductID.toString()+'/remove';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization':'Bearer '+apiToken
    };




    Map<String, dynamic > body = {
      'product_id': ProductID.toString(),
      'quantity': quantity.toString()
    };

    http.Response response = await http.post(url, headers: _Authheaders,body: body);
    switch(response.statusCode){
      case 200 :
      case 201 :
        return true ;
        break ;
      case 404 :
        throw ResourceNotFound('Categories');
        break ;
      case 301 :
      case 302 :
      case 303 :
        throw RedirectionFound();
        break ;
      default :
        return null;
        break ;
    }

  }


}
