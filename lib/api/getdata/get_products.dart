import 'package:flutter/widgets.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/Screens/Click_Product.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:pfe/Screens/product_category.dart' as pcateg;
import 'package:pfe/IconsNew/addidas.dart';
bool hassan = true;

class getProducts extends StatefulWidget {
  final categoryId;

  final categoryName;

  getProducts({this.categoryId, this.categoryName});

  @override
  _getProductsState createState() => _getProductsState();
}

class _getProductsState extends State<getProducts> {
  ProductApi productApi = new ProductApi();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        Container(
          height: SizeConfig.safeBlockVertical * 52,
          child: FutureBuilder(
              future: productApi.fetchProducts(1),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    __error('no connection!!!');
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return loading();
                    break;
                  case ConnectionState.done:
                    if (snapShot.hasError) {
                      return __error(snapShot.error.toString());
                    } else {
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: snapShot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          if (index > 3) {
                            return null;
                          } else {
                            return _product(snapShot.data[index]);
                          }
                        },
                      );
                    }
                    break;
                }
                return Container();
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: InkWell(
            onTap: () async {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=> new ProductCategory    ));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new pcateg.ProductCategory(
                            categoryId: widget.categoryId,
                            categoryName: widget.categoryName,
                          )));
              //  ProductCategory
            },
            child: Column(
              children: <Widget>[
                Text('Show More'),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        )
      ],
    );
  }

  _product(dynamic item) {
    return Card(
        child: Single_product(
      product_name: item.product_title.toString(),
      product_price: item.product_price.toString(),
      product_old_price: item.product_price,
      product_pic: item.featured_image(),
      product_description: item.product_description,
      product_id: item.product_id,
      productCountReview: item.productReviewCount,
      carouselImages: item.images_Carousel(),
    ));
  }

  __drawCard(dynamic item) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.product_id.toString()),
      ),
    );
  }

  __error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  __drawProduct(Product product) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(product.product_title),
          Image(
            image: product.images.length > 0
                ? NetworkImage(product.images[0])
                : NetworkImage(
                    'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'),
          )
        ],
      ),
    );
  }
}

class Single_product extends StatelessWidget {
  final product_name;
  final product_id;
  final product_pic;

  final product_price;

  final product_old_price;
  final product_description;
  final productCountReview;
  List carouselImages ;

  static Random random = new Random();
  int randNb = random.nextInt(100);

  Single_product({
    this.product_name,
    this.product_pic,
    this.product_price,
    this.product_old_price,
    this.product_description,
    this.product_id,
    this.productCountReview,
    this.carouselImages
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
            // Todo :: Make sure you establish the product tag very good
            tag: product_name + '$randNb',
            child: Material(
              child: InkWell(
                onTap: () async {
                  hassan = false;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Product_details(
                            product_details_name: product_name,
                            product_details_picture: product_pic,
                            product_details_price: product_price,
                            product_details_oldPrice: product_old_price,
                            product_description: product_description,
                            product_id: product_id,
                            productReviewCount: productCountReview,
                            carousel: this.carouselImages,
                          )));
                },
                child: GridTile(
                  footer: Container(
                    // height: 30.0,
                    color: Colors.white70,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "\$$product_price",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                product_name,
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: Image.network(
                    '${this.product_pic}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
