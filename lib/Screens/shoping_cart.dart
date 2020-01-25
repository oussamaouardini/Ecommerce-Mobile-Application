import 'package:flutter/material.dart';
import 'package:pfe/Component/List_View_Card.dart';
import 'Home.dart';

const appBarColor = Color(0xFF01B2C4);
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBarColor,

        title: ListTile(
          title: InkWell(child: Text('Shoping Cart',style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          ),),
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new home_screen()));
          },),
        ),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: cardlist() ,
      bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(child: ListTile(
                title: Text('Total :'),
                subtitle: Text("\$230"),
              )),
              Expanded(
                  child: MaterialButton(onPressed: (){},
                    child: Text('check out',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),),
                    color: appBarColor,
                  )
              ),
            ],
          )
      ),

    );
  }
}
