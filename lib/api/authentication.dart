import 'package:pfe/custom_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Future<User> register(String first_name, String last_name, String email,
      String password) async {
    print("hello1");
    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password
    };

    print("hello 2");
    http.Response response =
        await http.post(ApiUtl.AUTH_REGISTER, headers: headers, body: body);
    print("hello 3 "+ response.statusCode.toString());
    if(response.statusCode == 201){
      print("hello 4");
      // registration successfully
      var body = jsonDecode(response.body );
      var data = body['data'];
      print(data);
       return User.fromJson(data);

      
    }else{
      print("hello 5");
      // registration failed
      return null ;
    }



  }

  Future<User> login(String email, String password) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> body = {
      'email': email,
      'password': password
    };
    http.Response response =
    await http.post(ApiUtl.AUTH_LOGIN, headers: headers, body: body);

    if(response.statusCode == 200){
      // registration successfully
      var body = jsonDecode(response.body );
      var data = body['data'];
      User user = User.fromJson(data);
      await _saveUser(user.user_id,user.api_token);
      return user ;
    }else{
      // registration failed
      return null ;
    }

  }

  Future<void>_saveUser(int userID,String apiToken) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userID);
    sharedPreferences.setString('user_id', apiToken);
  }


}
