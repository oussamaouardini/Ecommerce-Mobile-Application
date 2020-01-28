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
    return MAIN_API_URL +'currentuser/1';
  }





}
