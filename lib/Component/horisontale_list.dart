import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pfe/product/product.dart';
import 'package:pfe/api/products_api.dart';

const CardColor = Color(0xFFF6F6F6);
const littleCardColor = Colors.white;
const littleCardTextColor = Colors.black;

class HorizontalList extends StatelessWidget {
  ProductApi productApi = new ProductApi();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xF2EEEF),
      height: 350.0,
      child: FutureBuilder(
          future: productApi.fetchProductsales(),
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
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    addAutomaticKeepAlives: true,
                    itemCount: snapShot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                        return Category(product: snapShot.data[index],);
                    },
                  );
                }
                break;
            }
            return Container();
          }),
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
}

class Category extends StatelessWidget {

  final Product product ;
  Category({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () {},
          child: Stack(
            children: <Widget>[
              Container(
                width: 190,
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GridTile(
                      child: Image.network(
                    product.featured_image(),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Positioned(
                top: 190,
                left: 19,
                child: LittleCard(
                  product: this.product,
                    ),
              ),
              Container(
                height: 10,
                color: Colors.red,
              ),
            ],
          )),
    );
  }
}

class LittleCard extends StatelessWidget {

  final Product product ;
  LittleCard({this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150.0,
      height: 135.0,
      child: Card(
        color: Colors.grey.shade800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Product name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                product.product_title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            ///  etoiles and nb sales
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(this.product.nb_sales.toString(),
                          style: TextStyle(
//                color: Colors.white
                              ))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 20.0,
                            color: Colors.amber,
                          ),
                          Text(this.product.productReviewCount.toString())
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            /// nb Available
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '150 Available',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0),
              child: new LinearPercentIndicator(
                width: 128.0,
                lineHeight: 5.0,
                percent: 0.3,
                progressColor: Colors.blue,
              ),
            ),
            ////
          ],
        ),
      ),
    );
  }
}
