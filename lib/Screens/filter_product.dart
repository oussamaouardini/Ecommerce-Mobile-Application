import 'package:flutter/material.dart';
import 'package:pfe/api/helpers_api.dart';
import 'package:pfe/constants.dart';
import 'package:pfe/product/product.dart';
import 'package:pfe/Screens/Click_Product.dart';

class FilterProduct extends StatefulWidget {
  List<dynamic> tab;

  FilterProduct(this.tab);

  @override
  _FilterProductState createState() => _FilterProductState();
}

class _FilterProductState extends State<FilterProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  HelpersApi helperApi = HelpersApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Filter Product"),
        backgroundColor: Constant.appBarColor,
      ),
      body: FutureBuilder(
        future: helperApi.filter(widget.tab),
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
                    itemCount: snapShot.data.length,
                    itemBuilder: (BuildContext context, int position) {
                      return _drawProduct(snapShot.data[position]);
                    });
              }
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _drawProduct(Product product) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Product_details(
                  product_details_name: product.product_title,
                  product_details_picture: product.featured_image(),
                  product_details_price: product.product_price,
                  product_details_oldPrice: product.product_price,
                  product_description: product.product_description,
                  product_id: product.product_id,
                )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              //  color: Colors.red,
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            // image: NetworkImage(cartItem.product.featured_image()),
                            image: NetworkImage(
                              product.featured_image()
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.product_title.substring(0,15),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('\$ ' + product.product_price.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}
