class User {
  String first_name;
  String last_name;
  String email;
  String api_token;
  int user_id;

  String password;
  String memberSince , shippingAddress ;
  String mobile;

  User(this.first_name, this.last_name, this.email,
      [this.api_token, this.user_id , this.password , this.memberSince , this.shippingAddress, this.mobile ]);

  User.fromJson(Map<String, dynamic> jsonObject) {

    this.user_id = jsonObject['user_id'];
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.api_token = jsonObject['api_token'];
    this.password = jsonObject['password'];
    this.memberSince = jsonObject['member_since'];
    this.mobile = jsonObject['mobile'];
    this.shippingAddress = jsonObject['address'] ;

  }
}
