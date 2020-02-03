class Reviewer{

  String first_name, last_name , formated_name ;

  Reviewer(this.first_name, this.last_name, this.formated_name);

  Reviewer.fromJson(  Map<String,dynamic>  jsonObject ){
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.formated_name = jsonObject['formated_name'];
  }

}