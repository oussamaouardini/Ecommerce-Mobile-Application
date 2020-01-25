import 'reviewer.dart';

class ProductReview{

int review_id , stars ;

String review ;
Reviewer reviewer ;

ProductReview(this.review_id, this.stars, this.review, this.reviewer);

ProductReview.fromJson(Map<String,dynamic> jsonObject ){
  this.review_id = int.tryParse(jsonObject['review_id']);
  this.stars = int.tryParse(jsonObject['stars']);
  this.review = jsonObject['review'];
  this.reviewer = Reviewer.fromJson(jsonObject['review_id']);
  

}

}