class ProductTag{

int tagId ;
String tagName ;

ProductTag({this.tagId,this.tagName});


ProductTag.fromJson(Map<String,dynamic> jsonObject ){
this.tagId = jsonObject['tag_id'];
this.tagName = jsonObject['tag_name'];
}



}