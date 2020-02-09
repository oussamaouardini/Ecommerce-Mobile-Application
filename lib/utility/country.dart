class Country {
  int countryId;

  String countryName, capital, currency;

  Country(this.countryId, this.countryName, this.capital, this.currency);

  Country.fromJson(Map<String, dynamic> jsonObject) {
    this.countryId = jsonObject['country_id'];
    this.countryName = jsonObject['country_name'];
    this.capital = jsonObject['capital'];
    this.currency = jsonObject['currency'];
  }
}
