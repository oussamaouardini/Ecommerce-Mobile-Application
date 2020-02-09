class User {
  int userId;

  String firstName, lastName, email, mobile, shippingAddress;

  User(this.userId, this.firstName, this.lastName, this.email, this.mobile,
      this.shippingAddress);

  User.fromJson(Map<String, dynamic> jsonObject) {
    this.userId = jsonObject['user_id'];
    this.firstName = jsonObject['first_name'];
    this.lastName = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.mobile = jsonObject['mobile'];
    this.shippingAddress = jsonObject['shipping_address'];
  }
}
