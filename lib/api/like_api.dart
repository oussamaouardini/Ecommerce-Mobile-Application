import 'package:http/http.dart' as http;
import 'package:pfe/api/api_util.dart';
import 'package:pfe/cart/cart.dart';
import 'dart:convert';

import 'package:pfe/exceptions/exceptions.dart';
import 'package:pfe/like/like.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeApi {
  Map<String, String> _headers = {'Accept': 'application/json'};

  Future<List<Like>> fetchUserLikes(int user_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };

    String url = ApiUtl.USERLIKES(user_id);

    http.Response response = await http.get(url, headers: _Authheaders);
    List<Like> Likes = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);

        for (var item in body['data']) {
          Likes.add(Like.fromJson(item));
        }
        return Likes;
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<Like>> removeUserLike(int user_id, int product_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };

    String url = ApiUtl.REMOVELIKE(user_id, product_id);
    print(url);
    http.Response response = await http.post(url, headers: _Authheaders);
    print(response.statusCode.toString());
    List<Like> Likes = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);

        for (var item in body['data']) {
          Likes.add(Like.fromJson(item));
        }
        return Likes;
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<Like>> addUserLike(int user_id, int product_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };

    String url = ApiUtl.ADDLIKE(user_id, product_id);
    print(url);
    http.Response response = await http.post(url, headers: _Authheaders);
    print(response.statusCode.toString());
    List<Like> Likes = [];
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);

        for (var item in body['data']) {
          Likes.add(Like.fromJson(item));
        }
        return Likes;
        break;
      case 404:
        throw ResourceNotFound('Cart');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }
}
