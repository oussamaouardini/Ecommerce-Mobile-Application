import 'dart:convert';

import 'package:pfe/api/api_util.dart';
import 'package:pfe/custom_widgets.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class UserApi{





  Future<User> fetchUser( int user_id  ) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization':'Bearer '+apiToken
    };

    String url = ApiUtl.FullUser(user_id);

    http.Response response = await http.get(url,headers: _Authheaders);

    if(response.statusCode == 200){
      var body =  jsonDecode(response.body);
      User user =  User.fromJson(body['data']) ;
      return user ;
    }



  }




}