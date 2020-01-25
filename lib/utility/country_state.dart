class CountryState {
  int state_id;

  String state_name;

  CountryState(this.state_id, this.state_name);

  CountryState.fromJson(Map<String, dynamic> jsonObject) {
    this.state_id = jsonObject['state_id'];
    this.state_name = jsonObject['state_name'];
  }
}
