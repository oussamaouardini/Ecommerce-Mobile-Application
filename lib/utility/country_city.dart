class CountryCity {
  int cityId;

  String cityName;

  CountryCity(this.cityId, this.cityName);

  CountryCity.fromJson(Map<String, dynamic> jsonObject) {
    this.cityId = jsonObject["city_id"];
    this.cityName = jsonObject["city_name"];
  }
}
