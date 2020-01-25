class Country {
  int country_id;

  String country_name, capital, currency;

  Country(this.country_id, this.country_name, this.capital, this.currency);

  Country.fromJson(Map<String, dynamic> jsonObject) {
    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.capital = jsonObject['capital'];
    this.currency = jsonObject['currency'];
  }
}
