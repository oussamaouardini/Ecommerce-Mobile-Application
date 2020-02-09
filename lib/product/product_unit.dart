class ProductUnit{


  int unitId ;
  String unitName , unitCode ;


ProductUnit({this.unitId,this.unitName,this.unitCode});

ProductUnit.fromJson(Map<String,dynamic> jsonObject ){

  this.unitId = jsonObject['unit_id'];
  this.unitName = jsonObject['unit_name'];
  this.unitCode = jsonObject['unit_code'];


}


}