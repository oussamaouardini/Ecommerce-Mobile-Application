import 'package:flutter/material.dart';

class All_Sports_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xF2EEEF),
      height: 250.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Item(
            image_location: 'images/iconsImgs/run.png',
            name: 'Running',
          ),
          Item(
            image_location: 'images/iconsImgs/hiking.png',
            name: 'Hicking',
          ),
          Item(
            image_location: 'images/iconsImgs/foot.png',
            name: 'Football',
          ),
          Item(
            image_location: 'images/iconsImgs/tennis.png',
            name: 'Tennis',
          ),
          Item(
            image_location: 'images/iconsImgs/fishing.png',
            name: 'Fishing',
          ),
          Item(
            image_location: 'images/iconsImgs/cardio.png',
            name: 'Cardio',
          ),
          Item(
            image_location: 'images/iconsImgs/swim.png',
            name: 'Swimming',
          ),
          Item(
            image_location: 'images/iconsImgs/surf.png',
            name: 'Surfing',
          ),

        ],
      ),
    );
  }
}



class Item extends StatelessWidget {

  final image_location ;
  final name ;
  Item({this.image_location,this.name});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        print(name);
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120.0,
        width: 190.0,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
        //  borderRadius: BorderRadius.all(Radius.circular(50.0)),
          //color: Colors.red,
          image: DecorationImage(
            image: new AssetImage(
                image_location),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Opacity(opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black45
                ),
              ),
            ),
            Container(
              child: Center(child: Text(name,style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold
              ),)),
            )
          ],
        ),
      ),
    );
  }
}
