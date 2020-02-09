import 'reviewer.dart';

class ProductReview{

int reviewId , stars ;
dynamic avgStart ;

String review ;
Reviewer reviewer ;

ProductReview(this.reviewId, this.stars, this.review, this.reviewer);

ProductReview.fromJson(Map<String,dynamic> jsonObject ){
  this.reviewId = jsonObject['review_id'];
  this.stars = jsonObject['stars'];
  this.review = jsonObject['review'];
  this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  this.avgStart = jsonObject['stars_avg'];
}

}