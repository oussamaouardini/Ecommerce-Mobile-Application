import 'package:flutter/widgets.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/Screens/Click_Product.dart';
import 'package:pfe/general_config/size_config.dart';

bool hassan = true;

class get_products extends StatefulWidget {
  @override
  _get_productsState createState() => _get_productsState();
}

class _get_productsState extends State<get_products> {
  ProductApi productApi = new ProductApi();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
     // height: SizeConfig.safeBlockVertical*30,
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
                    addAutomaticKeepAlives: false,
                    itemCount: snapShot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _product(snapShot.data[index]);
                    },
                  );
                }
                break;
            }
            return Container();
          }),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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

  static Random random = new Random();
  int randNb = random.nextInt(100);

  Single_product(
      {this.product_name,
      this.product_pic,
      this.product_price,
      this.product_old_price,
      this.product_description,
      this.product_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
            // Todo :: Make sure you establish the product tag very good
            tag: product_name + '$randNb',
            child: Material(
              child: InkWell(
                onTap: () {
                  hassan = false;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Product_details(
                            product_details_name: product_name,
                            product_details_picture: product_pic,
                            product_details_price: product_price,
                            product_details_oldPrice: product_old_price,
                            product_description: product_description,
                            product_id: product_id,
                          )));
                },
                child: GridTile(
                  footer: Container(
                    height: 30.0,
                    color: Colors.white70,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$$product_price",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              product_name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: Image.network(
                    'https://cdn2.newsok.biz/cache/lead630_blur-cee3691789e43fb1e475384d48db5c6f.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
