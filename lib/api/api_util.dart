import 'package:pfe/custom_widgets.dart';

class ApiUtl {
  //local Url
  static const String MAIN_API_URL = "http://10.0.2.2:8000/api/";

  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register';

  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login';

  static const String PRODUCTS = MAIN_API_URL + 'products';

  static const String PRODUCT_BY_ID = MAIN_API_URL + 'products/';

  static const String COUNTRIES = MAIN_API_URL + 'countries';

  static String CITIES(int id) {
    return MAIN_API_URL + 'countries/'+ id.toString() + '/cities';
  }

  static String STATES(int id) {
    return MAIN_API_URL +'countries/' + id.toString() + '/states';
  }

  static const String CATEGORIES = MAIN_API_URL + 'categories';
  static const String TAGS = MAIN_API_URL + 'tags';
  static const String CART = MAIN_API_URL + 'carts';

  static const String REMOVE_FROM_CART = MAIN_API_URL + 'carts';

  static String FullUser(int id) {
    return MAIN_API_URL +'currentuser/'+id.toString();
  }
  static String USERLIKES(int id) {
    return MAIN_API_URL +'wishuser/'+id.toString();
  }
  static String ADDLIKE(int id , int product_id) {
    return MAIN_API_URL +'addwishuser/'+id.toString()+'/'+product_id.toString();
  }
  static String REMOVELIKE(int id , int product_id) {
    return MAIN_API_URL +'removewishuser/'+id.toString()+'/'+product_id.toString();
  }
  static String PRODUCTBYCATEGORYID(int id) {
    return MAIN_API_URL +'categories/' + id.toString() + '/products';
  }
  static String PRODUCTREVIEWS(int id) {
    return MAIN_API_URL +'product/' + id.toString() + '/review';
  }
  static String EDITUSER(int id) {
    return MAIN_API_URL +'edituser/' + id.toString();
  }
  static String GETUSER(int id) {
    return MAIN_API_URL +'getuser/' + id.toString();
  }
  static String FILTER() {
    return MAIN_API_URL +'filter';
  }

  static String PRODUCTBYID(int id) {
    return MAIN_API_URL +'products/'+id.toString();
  }
  static String PRODUCTBYNAMELike(String name) {
    return MAIN_API_URL +'products/search/'+name.toString();
  }
  static String ADDNBSALES(int id) {
    return MAIN_API_URL +'products/sales/'+id.toString();
  }
  static String FLASHSALES() {
    return MAIN_API_URL +'products/product/sales';
  }


}
