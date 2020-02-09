class User {
  String firstName;
  String lastName;
  String email;
  String apiToken;
  int userId;

  String password;
  String memberSince , shippingAddress ;
  String mobile;

  User(this.firstName, this.lastName, this.email,
      [this.apiToken, this.userId , this.password , this.memberSince , this.shippingAddress, this.mobile ]);

  User.fromJson(Map<String, dynamic> jsonObject) {

    this.userId = jsonObject['user_id'];
    this.firstName = jsonObject['first_name'];
    this.lastName = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.apiToken = jsonObject['api_token'];
    this.password = jsonObject['password'];
    this.memberSince = jsonObject['member_since'];
    this.mobile = jsonObject['mobile'];
    this.shippingAddress = jsonObject['address'] ;

  }
}
