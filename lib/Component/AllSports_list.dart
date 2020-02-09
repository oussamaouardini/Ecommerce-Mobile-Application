import 'package:flutter/material.dart';
import 'package:pfe/Screens/product_category.dart';

class AllSportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xF2EEEF),
      height: 250.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Item(
            imageLocation: 'images/iconsImgs/run.png',
            name: 'Running',
            id: 1,
          ),
          Item(
            imageLocation: 'images/iconsImgs/hiking.png',
            name: 'Hicking',
            id: 2,
          ),
          Item(
            imageLocation: 'images/iconsImgs/foot.png',
            name: 'Football',
            id: 3,
          ),
          Item(
            imageLocation: 'images/iconsImgs/tennis.png',
            name: 'Tennis',
            id: 4,
          ),
          Item(
            imageLocation: 'images/iconsImgs/fishing.png',
            name: 'Fishing',
            id: 5,
          ),
          Item(
            imageLocation: 'images/iconsImgs/cardio.png',
            name: 'Cardio',
            id: 6,
          ),
          Item(
            imageLocation: 'images/iconsImgs/swim.png',
            name: 'Swimming',
            id: 7,
          ),
          Item(
            imageLocation: 'images/iconsImgs/surf.png',
            name: 'Surfing',
            id: 8,
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final imageLocation;

  final id;

  final name;

  Item({this.imageLocation, this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new ProductCategory(
                      categoryId: this.id,
                      categoryName: this.name,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120.0,
        width: 190.0,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          image: DecorationImage(
            image: new AssetImage(imageLocation),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black45),
              ),
            ),
            Container(
              child: Center(
                  child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
    );
  }
}
