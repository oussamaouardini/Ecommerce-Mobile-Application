class CountryState {
  int stateId;

  String stateName;

  CountryState(this.stateId, this.stateName);

  CountryState.fromJson(Map<String, dynamic> jsonObject) {
    this.stateId = jsonObject['state_id'];
    this.stateName = jsonObject['state_name'];
  }
}
