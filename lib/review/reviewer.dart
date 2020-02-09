class Reviewer{

  String firstName, lastName , formatedName ;

  Reviewer(this.firstName, this.lastName, this.formatedName);

  Reviewer.fromJson(  Map<String,dynamic>  jsonObject ){
    this.firstName = jsonObject['first_name'];
    this.lastName = jsonObject['last_name'];
    this.formatedName = jsonObject['formated_name'];
  }

}