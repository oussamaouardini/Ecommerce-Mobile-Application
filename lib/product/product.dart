import 'package:pfe/product/product_category.dart';
import 'package:pfe/product/product_unit.dart';
import 'package:pfe/product/product_tag.dart';
import 'package:pfe/review/product_review.dart';
import 'package:pfe/exceptions/exceptions.dart';

class Product {
  int product_id, productReviewCount , nb_sales , productQuantity ;

  String product_title, product_description;



  double product_price;

  ProductCategory productCategory;

  List<ProductTag> tags;

  List<String> images;
  List<ProductReview> reviews;

  Product(
      this.product_id,
      this.product_title,
      this.product_description,
      this.product_price,
      this.productCategory,
      this.tags,
      this.images,
      this.reviews,
      this.productReviewCount,
      this.nb_sales
      );

  Product.fromJson(Map<String, dynamic> jsonObject) {
    if (jsonObject['product_id'] == null) {
      throw PropoertyIsRequired('Product ID');
    }
    if (jsonObject['product_title'] == null) {
      throw PropoertyIsRequired('Product ID');
    }
    if (jsonObject['product_description'] == null) {
      throw PropoertyIsRequired('Product ID');
    }
    if (jsonObject['product_price'] == null) {
      throw PropoertyIsRequired('Product ID');
    }

    this.product_id = jsonObject['product_id'];
    this.productReviewCount = jsonObject['product_reviews_count'];
    this.nb_sales = jsonObject['product_nb_sales'];
    this.productQuantity = jsonObject['product_quantity'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];

    this.product_price = double.tryParse(jsonObject['product_price']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    _setImages(jsonObject['product_images']);
    // _setReviews(jsonObject['product_reviews']);
    //   this.productUnit =jsonObject['product_id'];
  }

  Product.fromHelper(Map<String, dynamic> jsonObject) {
    this.product_id = jsonObject['id'];
    this.productReviewCount = jsonObject['product_reviews_count'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_price = double.tryParse(jsonObject['product_price']);
    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    _setImages(jsonObject['product_images']);
    // _setReviews(jsonObject['product_reviews']);
    //   this.productUnit =jsonObject['product_id'];
  }

  void _setImages(List<dynamic> jsonImages) {
    images = [];
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != null) {
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featured_image() {
    if (this.images.length > 0) {
      return this.images[0];
    }
    return 'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg';
  }
}
