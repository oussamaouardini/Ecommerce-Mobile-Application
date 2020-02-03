import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:pfe/Component/horisontal_list_with_litle_card.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pfe/api/products_api.dart';
const CardColor = Color(0xFFF6F6F6);
const litleCardColor = Colors.white;
const litleCardTextColor = Colors.black;

class Horizintal_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xF2EEEF),

      height: 350.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/AllSports/run100.png',
            image_caption: 'shirt',
          ),
          Category(
            image_location: 'images/cats/dress.png',
            image_caption: 'dress',
          ),
          Category(
            image_location: 'images/cats/jeans.png',
            image_caption: 'Pants',
          ),
          Category(
            image_location: 'images/cats/formal.png',
            image_caption: 'formal',
          ),
          Category(
            image_location: 'images/cats/informal.png',
            image_caption: 'informal',
          ),
          Category(
            image_location: 'images/cats/shoe.png',
            image_caption: 'shoes',
          ),
          Category(
            image_location: 'images/cats/accessories.png',
            image_caption: 'accessories',
          ),
        ],
      ),
    );
  }
}


class Category extends StatelessWidget {
  final image_location;

  final image_caption;

  Category({this.image_caption, this.image_location});

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
                    child: Image.asset(
                      image_location,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Positioned(
              top : 190,
              left : 19,
              child : LittleCard(image_location: image_location,image_name: image_caption),
            ),
            Container(
              height: 10,
              color: Colors.red,
            ),
          ],
        )
      ),
    );
  }
}

class LittleCard extends StatelessWidget
{

  final image_location;
  final image_name;

  LittleCard({this.image_name, this.image_location});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      width: 150.0,
      height: 135.0,
      child: Card(
        color: Colors.grey.shade800,
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: <Widget>[

            /// Product name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                image_name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ///  etoiles and nb sales
            Padding(
              padding: const EdgeInsets.only(left : 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("150 sales",style: TextStyle(
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
                          Icon(Icons.star,
                            size: 20.0,
                            color: Colors.amber ,),
                          Text("4.5")
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
              padding: const EdgeInsets.only(left:5.0, top :5.0),
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






