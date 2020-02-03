import 'dart:convert';

import 'package:pfe/custom_widgets.dart';
import 'package:http/http.dart' as http;

class ReviewApi{

  Map<String,String> headers = {
    'Accept':'application/json'
  };

  Future<List<ProductReview>> fetchReviews(int id , int paginate) async{


    String url = ApiUtl.PRODUCTREVIEWS(id) ;
    http.Response response = await http.get(url,headers: headers);

    List<ProductReview> reviews = [];
    if(response.statusCode == 200){
      var body =  jsonDecode(response.body);
      for(var item in body['data'] ){
        reviews.add(
            ProductReview.fromJson(item)
        );
      }
      return reviews ;
    }
    return reviews ;

  }



}