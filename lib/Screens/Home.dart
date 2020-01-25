import 'package:flutter/material.dart';
import 'package:pfe/Component/Bar.dart';
import 'package:pfe/Component/horisontale_list.dart';
import 'package:pfe/Component/image_caroussel.dart';
import 'package:pfe/Component/AllSports_list.dart';
import 'package:pfe/Component/gridViewList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Account.dart';
import 'shoping_cart.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:pfe/api/getdata/get_products.dart';

//import 'package:pfe/custom_widgets.dart';
const AppColor = Color(0xF2EEEF);
const appPadding = 10.0 ;

class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  final PageController _pageController = new PageController();

  int changePage = 0;

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: (index){
              print("Selected Index: $index");
              if(index==4){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Account()));
              }else if(index==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
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
      drawer: _drawer(),
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
                height: 400,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      child: Products(tagSection: 'recommended for you',),
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.blue,
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
              Bar(first: 'Shirts',second: 'Pants',third: 'Accesories',),
              SizedBox(height: 20,),
              Container(
                height: 400,
                child: Products(tagSection: 'brand',),
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




class _drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("ouballa mohamed"),
              accountEmail: Text("hamid.ikchawn@ouballa.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.grey),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Home"),
                leading: Icon(
                  Icons.home,
                 // color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Notifications"),
                leading: Icon(
                  Icons.notifications,
              //    color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My orders"),
                leading: Icon(
                  Icons.shopping_basket ,
                //  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Wish List"),
                leading: Icon(
                  Icons.favorite,
                //  color: Colors.red,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Text("Products",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,

                  ),),

                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Categories"),
                leading: Icon(
                  Icons.dashboard,
                //  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Brands"),
                leading: Icon(
                  Icons.flag,
                  //  color: Colors.red,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Text("Application preferences",style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,

                  ),),

                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Log Out"),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About"),
                leading: Icon(
                  Icons.format_paint,
                  color: Colors.blue,
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}

