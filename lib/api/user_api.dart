import 'package:pfe/custom_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditUser {
  Future<User> edit(String first_name, String last_name, String email,
      String address, String mobile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');
    int user_id = sharedPreferences.getInt('user_id');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'address': address,
      'mobile': mobile
    };

    http.Response response = await http.post(ApiUtl.EDITUSER(user_id),
        headers: _Authheaders, body: body);
    if ((response.statusCode == 201) || (response.statusCode == 200)) {
      // registration successfully
      var body = jsonDecode(response.body);
      var data = body;
      return User.fromJson(data);
    } else {
      // edit failed
      return null;
    }
  }

  Future<void> _saveUser(int userID, String apiToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userID);
    sharedPreferences.setString('api_token', apiToken);
  }


  Future<User> getUser( int user_id  ) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
      'Authorization':'Bearer '+apiToken
    };

    String url = ApiUtl.GETUSER(user_id);

    http.Response response = await http.get(url,headers: _Authheaders);

    if(response.statusCode == 200){
      var body =  jsonDecode(response.body);
      User user =  User.fromJson(body['data']) ;
      return user ;
    }



  }
}
