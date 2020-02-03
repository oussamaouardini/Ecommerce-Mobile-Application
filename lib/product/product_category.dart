class ProductCategory{

  int category_id ;
  String category_name ;


ProductCategory({this.category_id,this.category_name});

ProductCategory.fromJson( Map<String, dynamic> jsonObject ){
  this.category_id = jsonObject['category_id'];
  this.category_name = jsonObject['category_name'];
}


}