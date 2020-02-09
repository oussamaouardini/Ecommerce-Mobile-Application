



import 'package:pfe/custom_widgets.dart';
import 'package:pfe/product/product.dart';

class Like {

  int userId ;
  Product product ;


  Like.fromJson( Map<String,dynamic> jsonObject ){
    this.userId = jsonObject['user_id'];
    this.product = Product.fromJson(jsonObject['product']);
  }


}






