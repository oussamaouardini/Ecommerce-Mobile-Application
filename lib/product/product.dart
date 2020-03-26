import 'package:pfe/custom_widgets.dart';
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
  List<dynamic> carouselImages ;

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
      this.nb_sales,
      this.carouselImages
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
    images_Carousel();

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
    images_Carousel();

    // _setReviews(jsonObject['product_reviews']);
    //   this.productUnit =jsonObject['product_id'];
  }

  void _setImages(String json) {
    List<dynamic> jsonImages = [];
    jsonImages = jsonDecode(json);
    this.images = [];
    if (jsonImages.length > 0) {
      for (var image in jsonImages) {
        if (image != null) {
          this.images.add(image);
        }
      }
    }
  }
  List<dynamic> images_Carousel() {
    this.carouselImages = [];
    for(var image in this.images){
      this.carouselImages.add(NetworkImage("${ApiUtl.MAIN_IMAGES_URL}"+"$image"));
    }
    return this.carouselImages ;
  }

  String featured_image() {
    if (this.images.length > 0) {
      return "${ApiUtl.MAIN_IMAGES_URL}"+"${this.images[0]}";
    }
    return 'https://cdn.discordapp.com/attachments/671407027871940609/692461617488723999/no-image-available.png';
  }
}
