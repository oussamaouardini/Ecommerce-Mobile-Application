import 'package:pfe/exceptions/exceptions.dart';
import 'package:pfe/product/product.dart';
import 'package:pfe/utility/country.dart';
import 'package:pfe/product/product_tag.dart';
import 'package:pfe/product/product_category.dart';
import 'package:pfe/utility/country_city.dart';
import 'package:pfe/utility/country_state.dart';
import 'api_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class HelpersApi {


  Map<String, String> _headers = {'Accept': 'application/json'};

  Future<List<ProductCategory>> fetchCategories(int page) async {
    String url = ApiUtl.CATEGORIES + '?page=' + page.toString();

    http.Response response = await http.get(url, headers: _headers);
    List<ProductCategory> categories = [];
    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          categories.add(ProductCategory.fromJson(item));
        }
        return categories;
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

  Future<List<ProductTag>> fetchtags(int page) async {
    String url = ApiUtl.TAGS + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: _headers);
    List<ProductTag> tags = [];
    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          tags.add(ProductTag.fromJson(item));
        }
        return tags;
        break ;
      case 404 :
        throw ResourceNotFound('TAGS');
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

  Future<List<Country>> fetchCountries(int page) async {
    String url = ApiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: _headers);

    List<Country> countries = [];

    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          countries.add(Country.fromJson(item));
        }
        return countries;
        break ;
      case 404 :
        throw ResourceNotFound('Coutries');
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

  Future<List<CountryState>> fetchStates(int _country, int page) async {

    print("state");
    String url = ApiUtl.STATES(_country) + '?page=' + page.toString();
    print(url);
    http.Response response = await http.get(url, headers: _headers);
    print("oussm");
    print(response.statusCode.toString());
    List<CountryState> states = [];
    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
      for (var item in body['data']) {
        states.add(CountryState.fromJson(item));
      }
        return states;
      break ;
      case 404 :
        throw ResourceNotFound('States');
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

  Future<List<CountryCity>> fetchCities(int country_id, int page) async {
    String url = ApiUtl.CITIES(country_id) + '?page=' + page.toString();

    http.Response response = await http.get(url, headers: _headers);

    List<CountryCity> cities = [];

    switch(response.statusCode){
      case 200 :
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          cities.add(CountryCity.fromJson(item));
        }
        return cities;
        break ;
      case 404 :
        throw ResourceNotFound('Cities');
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



  Future<List<dynamic>> filter(List<dynamic> tab) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.getString('api_token');
    int user_id = sharedPreferences.getInt('user_id');

    Map<String, String> _Authheaders = {
      'Accept': 'application/json',
     // 'Authorization': 'Bearer ' + apiToken
    };

    Map<String, String> body = {
      'tab': jsonEncode(tab),
    };
  //  print(ApiUtl.FILTER());
    http.Response response = await http.post(ApiUtl.FILTER(),
        headers: _Authheaders, body: body );
    List<dynamic> products = [];
    if ((response.statusCode == 201) || (response.statusCode == 200)) {
      // registration successfully
      var bodyy =  jsonDecode(response.body) ;
      for(int i = 0 ; i < tab.length ; i++ ){
        for(int j = 0 ; j < bodyy[i]['data'].length ; j++ ){

          http.Response response2 = await http.get(ApiUtl.PRODUCTBYID(bodyy[i]['data'][j]['id']),
              headers: _Authheaders );
          if ((response2.statusCode == 201) || (response2.statusCode == 200)) {
            var bodies =  jsonDecode(response2.body);
            products.add(
                Product.fromJson(bodies)
            );
          }
        }
      }
      return products ;
    } else {
      // edit failed
      return null;
    }
  }


}
