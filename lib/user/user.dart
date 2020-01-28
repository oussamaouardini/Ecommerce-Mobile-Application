import 'package:pfe/product/product_category.dart';
import 'package:pfe/product/product_unit.dart';
import 'package:pfe/product/product_tag.dart';
import 'package:pfe/review/product_review.dart';
import 'package:pfe/exceptions/exceptions.dart';

class User {


  int user_id;

  String first_name, last_name , email ,mobile ,shipping_address;


  User(this.user_id, this.first_name, this.last_name, this.email, this.mobile,
      this.shipping_address);

  User.fromJson(Map<String, dynamic> jsonObject){

    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email=jsonObject['email'];
    this.mobile= jsonObject['mobile'];
    this.shipping_address=jsonObject['shipping_address'];

  }

}