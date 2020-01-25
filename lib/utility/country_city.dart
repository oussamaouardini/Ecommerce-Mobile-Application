class CountryCity {
  int city_id;

  String city_name;

  CountryCity(this.city_id, this.city_name);

  CountryCity.fromJson(Map<String, dynamic> jsonObject) {
    this.city_id = jsonObject["city_id"];
    this.city_name = jsonObject["city_name"];
  }
}
