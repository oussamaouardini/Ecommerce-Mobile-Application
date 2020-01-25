class ProductTag{

int tag_id ;
String tag_name ;

ProductTag({this.tag_id,this.tag_name});


ProductTag.fromJson(Map<String,dynamic> jsonObject ){
this.tag_id = jsonObject['tag_id'];
this.tag_name = jsonObject['tag_name'];
}



}