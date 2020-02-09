class ProductCategory{

  int categoryId ;
  String categoryName ;


ProductCategory({this.categoryId,this.categoryName});

ProductCategory.fromJson( Map<String, dynamic> jsonObject ){
  this.categoryId = jsonObject['category_id'];
  this.categoryName = jsonObject['category_name'];
}


}