import 'package:flutter/material.dart';
import 'package:pfe/Component/Bar.dart';
import 'package:pfe/Component/horisontale_list.dart';
import 'package:pfe/Component/image_caroussel.dart';
import 'package:pfe/Component/AllSports_list.dart';
import 'package:pfe/Component/gridViewList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/Screens/favorite_screen.dart';
import 'package:pfe/general_config/size_config.dart';
import 'Account.dart';
import 'shoping_cart.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:pfe/api/getdata/get_products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/Component/drawer.dart';

//import 'package:pfe/custom_widgets.dart';
const AppColor = Color(0xF2EEEF);
const appPadding = 10.0 ;

class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  final PageController _pageController = new PageController();
  final PageController _secondpageController = new PageController();

  int changePage = 0;

  int currentIndex = 0;

  int userId ;
  String api_token ;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF0EDED),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: AppColor,
        title: Text('HOME',style:TextStyle(
          color: Colors.black87,
        ),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black87), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
          }),
          CircleAvatar(
            backgroundColor: Color(0xF2EEEF),
            child: IconButton(icon: Icon(Icons.person,color: Colors.black,),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new Account()));

            },),
          ),
        ],
      ),
      /*
      bottomNavigationBar: Container(
        child:  BottomNavigationDotBar (// Usar -> "BottomNavigationDotBar"

            items: <BottomNavigationDotBarItem>[
              BottomNavigationDotBarItem(icon: Icons.home, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
              BottomNavigationDotBarItem(icon: Icons.person, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
              BottomNavigationDotBarItem(icon: Icons.favorite, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
            ]
        ),
      ),*/
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 0, // Use this to update the Bar giving a position
            onTap: (index) async {
              print("Selected Index: $index");
              if(index==4){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Account()));
              }else if(index==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
              }else if(index==2){
                SharedPreferences pref = await SharedPreferences.getInstance();
                 int user_id =  pref.getInt('user_id');
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Favorite(user_id:user_id) ));
              }
            },
            items: [
              TitledNavigationBarItem(title: 'Home', icon: Icons.home),
              TitledNavigationBarItem(title: 'Search', icon: Icons.search),
              TitledNavigationBarItem(title: 'Favorite', icon: Icons.favorite),
              TitledNavigationBarItem(title: 'Orders', icon: Icons.shopping_cart),
              TitledNavigationBarItem(title: 'Profile', icon: Icons.person_outline),
            ]
        ),
      drawer: drawerr(),
      body: Padding(

        padding: const EdgeInsets.only(top:5),
        child: Container(
          color: Color(0xF2EEEF),
          child: ListView(
           // physics:NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          splashColor: Colors.grey,
                          icon: Icon(Icons.search, color: Colors.black87),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                                hintText: "Search..."),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (context){
                                    return AlertDialog(title: Text("All Filters"),
                                      content: Text('chose the Quantity'),
                                      actions: <Widget>[
                                        MaterialButton(
                                          onPressed: (){
                                            Navigator.of(context).pop(context);
                                          },
                                          child: Text('Close'),
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child:Icon(FontAwesomeIcons.slidersH,) ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: appPadding,left: appPadding),
                child: ImageCarousel,
              ),
              /// Flash Seles Section  ==========================================================
              Padding(
                padding: EdgeInsets.all(appPadding),
                child:Row(
                  children: <Widget>[
                    Expanded(child: Row(
                      children: <Widget>[

                        Icon(FontAwesomeIcons.bullhorn,
                          size: 30.0,
                        ),
                        Text('  Flash Seles',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    )
                    ),
                    Expanded(child: Text(
                      'End in 07:56:00',
                      textAlign: TextAlign.right,
                    ))
                    ,
                  ],

                ),
              ),
            Horizintal_list(),
              /// Recommended For You Section ==========================================================
              Padding(
                padding: EdgeInsets.all(appPadding+10),
                child:Row(
                  children: <Widget>[

                    Expanded(child: Row(
                      children: <Widget>[

                        Icon(Icons.star,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                        Text('Recommended For You',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    )
                    ),
                  ],
                ),
              ),
              ///  BAR---Recommended For You Section =========
                Bar(first: 'Man',second: 'Women',third: 'Kids',firstIcon: FontAwesomeIcons.male,secondIcon: FontAwesomeIcons.female,thirdIcon: FontAwesomeIcons.child,pageController: _pageController,),
              SizedBox(height: 20,),
              Container(
                height: SizeConfig.blockSizeVertical*54,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    Container(
                      child: get_products(),
                    ),
                    Container(
                      child: get_products(),
                    ),
                    Container(
                      child: get_products(),
                    ),
                  ],
                ),
              ),
              /// Brands Section ==========================================================
              Padding(
                padding: EdgeInsets.all(appPadding+10),
                child:Row(
                  children: <Widget>[

                    Expanded(child: Row(
                      children: <Widget>[

                        Icon(FontAwesomeIcons.flag,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                        Text('  Brands',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    )
                    ),
                  ],
                ),
              ),
              ///  BAR---Recommended For You Section =========
              Bar(first: 'Man',second: 'Women',third: 'Kids',firstIcon: FontAwesomeIcons.male,secondIcon: FontAwesomeIcons.female,thirdIcon: FontAwesomeIcons.child,pageController: _secondpageController,),
              SizedBox(height: 20,),
              Container(
                height: SizeConfig.blockSizeVertical*54,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _secondpageController,
                  children: <Widget>[
                    Container(
                      child: get_products(),
                    ),
                    Container(
                      child: get_products(),
                    ),
                    Container(
                      child: get_products(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(appPadding+10),
                child:Row(
                  children: <Widget>[

                    Expanded(child: Row(
                      children: <Widget>[

                        Icon(Icons.outlined_flag,
                         // color: Colors.amber,
                          size: 30.0,
                        ),
                        RichText(
                          text: TextSpan(

                            children: <TextSpan>[
                              TextSpan(text: 'ALL',style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )),
                              TextSpan(text: ' Sports',style:TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ) ),
                            ],
                          ),
                        ),
                      ],
                    )
                    ),
                  ],
                ),
              ),
               All_Sports_List(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: get_products(),
              )

            ],
          ),
        ),
      ),
    );
  }
}


