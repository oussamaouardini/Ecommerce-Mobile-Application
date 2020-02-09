import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pfe/Screens/Click_Product.dart';
import 'dart:math';

bool hassan = true;

class Products extends StatefulWidget {
  final tagSection;

  Products({this.tagSection});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      'name': "blazer",
      'picture': "images/products/blazer1.jpeg",
      'old_price': 120,
      'price': 85,
    },
    {
      'name': "Red dress",
      'picture': "images/products/blazer2.jpeg",
      'old_price': 100,
      'price': 50,
    },
    {
      'name': "blazer0",
      'picture': "images/products/dress1.jpeg",
      'old_price': 90,
      'price': 85,
    },
    {
      'name': "Red dress1",
      'picture': "images/products/dress2.jpeg",
      'old_price': 100,
      'price': 50,
    },
    {
      'name': "blazer2",
      'picture': "images/products/hills1.jpeg",
      'old_price': 120,
      'price': 85,
    },
    {
      'name': "Red dress3",
      'picture': "images/products/hills2.jpeg",
      'old_price': 100,
      'price': 50,
    },
    {
      'name': "blazer4",
      'picture': "images/products/pants1.jpg",
      'old_price': 120,
      'price': 85,
    },
    {
      'name': "Red dress5",
      'picture': "images/products/pants2.jpeg",
      'old_price': 100,
      'price': 50,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: false,
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Single_product(
          product_name: productList[index]['name'],
          product_pic: productList[index]['picture'],
          product_price: productList[index]['price'],
          product_old_price: productList[index]['old_price'],
        );
      },
    );
  }
}

class Single_product extends StatelessWidget {
  final product_name;

  final product_pic;

  final product_price;

  final product_old_price;

  static Random random = new Random();
  int randNb = random.nextInt(100);

  Single_product(
      {this.product_name,
      this.product_pic,
      this.product_price,
      this.product_old_price});

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
                          )));
                },
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        title: Text(
                          "\$$product_price",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Text(
                          product_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "\$$product_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      product_pic,
                      fit: BoxFit.cover,
                    )),
              ),
            )),
      ),
    );
  }
}

class Sp extends StatelessWidget {
  final product_name;

  final product_pic;

  final product_price;

  final product_old_price;

  Sp(
      {this.product_name,
      this.product_pic,
      this.product_price,
      this.product_old_price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(
        children: <Widget>[
          Card(
            child: Hero(
                tag: product_name,
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: GridTile(
                        footer: Container(
                          color: Colors.white70,
                          child: ListTile(
                            title: Text(
                              "\$$product_price",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            leading: Text(
                              product_name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "\$$product_old_price",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ),
                        child: Image.asset(
                          product_pic,
                          fit: BoxFit.cover,
                        )),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
