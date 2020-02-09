import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

const CardColor = Color(0xFFF6F6F6);
const littleCardColor = Colors.white;
const littleCardTextColor = Colors.black;

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xF2EEEF),
      height: 350.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLocation: 'images/flashseles/blue.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/choes.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/colone.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/girl.jpg',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/girlpink.jpg',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/green.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/pink.jpg',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/ramos.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/red.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/shoes1.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/AllSports/run100.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'images/flashseles/shoes2.png',
            imageCaption: 'shoes',
          ),
          Category(
            imageLocation: 'images/flashseles/slip.png',
            imageCaption: 'accessories',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final imageLocation;

  final imageCaption;

  Category({this.imageCaption, this.imageLocation});

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
                    imageLocation,
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Positioned(
                top: 190,
                left: 19,
                child: LittleCard(
                    imageLocation: imageLocation, imageName: imageCaption),
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
  final imageLocation;
  final imageName;

  LittleCard({this.imageName, this.imageLocation});

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
                imageName,
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
                      Text("150 sales",
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
