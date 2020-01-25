class ProductUnit{


  int unit_id ;
  String unit_name , unit_code ;


ProductUnit({this.unit_id,this.unit_name,this.unit_code});

ProductUnit.fromJson(Map<String,dynamic> jsonObject ){

  this.unit_id = jsonObject['unit_id'];
  this.unit_name = jsonObject['unit_name'];
  this.unit_code = jsonObject['unit_code'];


}


}