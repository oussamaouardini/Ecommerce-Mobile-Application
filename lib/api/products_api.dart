import 'dart:convert';

import 'api_util.dart';
import 'package:pfe/product/product.dart';
import 'package:http/http.dart' as http;
class ProductApi{


  Map<String,String> headers = {
    'Accept':'application/json'
  };


Future<List<Product>> fetchProducts( int page  ) async{


String url = ApiUtl.PRODUCTS+'?page='+page.toString();
http.Response response = await http.get(url,headers: headers);

List<Product> products = [];
if(response.statusCode == 200){
  var body =  jsonDecode(response.body);
  for(var item in body['data'] ){
    products.add(
        Product.fromJson(item)
    );
  }
  return products ;
}
  return products ;


}

Future<Product> fetchProduct( int product_id  ) async{


  String url = ApiUtl.PRODUCT_BY_ID +product_id.toString();
  http.Response response = await http.get(url,headers: headers);

  List<Product> products = [];
  if(response.statusCode == 200){
    var body =  jsonDecode(response.body);
    return Product.fromJson(body['data']);
  }else{
    return null ;
  }

}

  Future<List<Product>> fetchProductsGategory( int categoryId  ) async{


    String url = ApiUtl.PRODUCTBYCATEGORYID(categoryId);
    http.Response response = await http.get(url,headers: headers);

    List<Product> products = [];
    if(response.statusCode == 200){
      var body =  jsonDecode(response.body);
      for(var item in body['data'] ){
        products.add(
            Product.fromJson(item)
        );
      }
      return products ;
    }
    return products ;

  }




}