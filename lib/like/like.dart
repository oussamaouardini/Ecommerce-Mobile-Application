



import 'package:pfe/custom_widgets.dart';
import 'package:pfe/product/product.dart';

class Like {

  int user_id ;
  Product product ;


  Like.fromJson( Map<String,dynamic> jsonObject ){
    this.user_id = jsonObject['user_id'];
    this.product = Product.fromJson(jsonObject['product']);
  }


}






