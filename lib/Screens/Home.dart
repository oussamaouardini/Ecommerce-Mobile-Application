import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pfe/Component/Bar.dart';
import 'package:pfe/Component/horisontale_list.dart';
import 'package:pfe/Component/image_caroussel.dart';
import 'package:pfe/Component/AllSports_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/Screens/logIn_screen.dart';
import 'package:pfe/Screens/search_product.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/general_config/size_config.dart';
import 'Account.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'shoping_cart.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:pfe/api/getdata/get_products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/Component/drawer.dart';
import 'package:pfe/general_config/functions.dart';
import 'package:pfe/user/user_api.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:pfe/cart/cart.dart' as cart;
import 'dart:core';
const AppColor = Color(0xF2EEEF);
const appPadding = 10.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserApi userApi = UserApi();

  final PageController _pageController = new PageController();
  final PageController _secondpageController = new PageController();
  int changePage = 0;
  int currentIndex = 0;
  int userId;

  String apiToken;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    User currentuser ;
    return WillPopScope(
      onWillPop: () {
        return moveToLastScreen();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFF0EDED),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                int userId = pref.getInt('user_id');
                String apiToken = pref.getString('api_token');

                if ((userId != null) || (apiToken != null)) {
                //  currentuser = await userApi.fetchUser(userId);
                  _scaffoldKey.currentState.openDrawer();
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Alert();
                      });
                }
              }),
          elevation: 0.0,
          backgroundColor: Color(0XFF191919),
          title: Image.network("https://cdn.discordapp.com/attachments/671407027871940609/675722336691027978/logo.png"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  int userId = pref.getInt('user_id');
                  String apiToken = pref.getString('api_token');
                  if ((userId != null) || (apiToken != null)) {

                    CartApi cartApi = CartApi() ;
                    cart.Cart car = await  cartApi.fetchCart();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new Cart(car.total)));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Alert();
                        });
                  }
                }),
            CircleAvatar(
              backgroundColor: Color(0XFF191919),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  int userId = pref.getInt('user_id');
                  String apiToken = pref.getString('api_token');
                  if ((userId != null) || (apiToken != null)) {
                    User user = await userApi.fetchUser(userId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Account(
                                  firstName: user.first_name,
                                  lastName: user.last_name,
                                  email: user.email,
                                  password: user.password,
                              memberSince: user.memberSince,
                              mobile: user.mobile,
                              shippingAdress: user.shippingAddress,
                                )));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Alert();
                        });
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 0,
            onTap: (index) async {
              functions.route_bottom_bar(index, context);
            },
            items: [
              TitledNavigationBarItem(title: 'Home', icon: Icons.home),
              TitledNavigationBarItem(title: 'Search', icon: Icons.search),
              TitledNavigationBarItem(title: 'Favorite', icon: Icons.favorite),
              TitledNavigationBarItem(
                  title: 'Orders', icon: Icons.shopping_cart),
              TitledNavigationBarItem(
                  title: 'Profile', icon: Icons.person_outline),
            ]),
        drawer:Drawerr(),
      //  drawer: drawer() ,
        endDrawer:  ExpansionTileSample(),
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
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
                            onPressed: () async {
                              if(searchController.text.isEmpty ){

                              }else{
                                ProductApi productApi = ProductApi() ;
                                List<Product> product = await productApi.fetchProductByName(searchController.text.toString()) ;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> new SearchProduct(product) ));
                              }

                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller:searchController,
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
                                _scaffoldKey.currentState.openEndDrawer();
//                                showDialog(
//                                    context: context,
//                                    builder: (context) {
//                                      return AlertDialog(
//                                        title: Text("All Filters"),
//                                        content: Text('chose the Quantity'),
//                                        actions: <Widget>[
//                                          MaterialButton(
//                                            onPressed: () {
//                                              Navigator.of(context)
//                                                  .pop(context);
//                                            },
//                                            child: Text('Close'),
//                                          )
//                                        ],
//                                      );
//                                    });
//                              return Container(
//                                height: 80.0,
//                                color: Colors.red,
//                                width: 45.0,
//                              );
                              },
                              child: Icon(
                                FontAwesomeIcons.slidersH,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: appPadding, left: appPadding),
                  child: ImageCarousel,
                ),

                /// Flash Seles Section  ==========================================================
                Padding(
                  padding: EdgeInsets.all(appPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.bullhorn,
                            size: 30.0,
                          ),
                          Text(
                            '  Flash Seles',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      Expanded(
                          child: Text(
                        'End in 07:56:00',
                        textAlign: TextAlign.right,
                      )),
                    ],
                  ),
                ),
                Horizintal_list(),

                /// Recommended For You Section ==========================================================
                Padding(
                  padding: EdgeInsets.all(appPadding + 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 30.0,
                          ),
                          Text(
                            'Recommended For You',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                    ],
                  ),
                ),

                ///  BAR---Recommended For You Section =========
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Bar(
                        first: 'Man',
                        second: 'Women',
                        third: 'Kids',
                        firstIcon: FontAwesomeIcons.male,
                        secondIcon: FontAwesomeIcons.female,
                        thirdIcon: FontAwesomeIcons.child,
                        pageController: _pageController,
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      height: SizeConfig.blockSizeHorizontal*13.7,
                      width: SizeConfig.blockSizeHorizontal*15,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 60,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: <Widget>[
                      Container(
                        child: getProducts(
                          categoryId: 9,
                          categoryName: 'Man',
                        ),
                      ),
                      Container(
                        child: getProducts(
                          categoryId: 10,
                          categoryName: 'Women',
                        ),
                      ),
                      Container(
                        child: getProducts(
                          categoryId: 11,
                          categoryName: 'Kids',
                        ),
                      ),
                    ],
                  ),
                ),

                /// Brands Section ==========================================================
                Padding(
                  padding: EdgeInsets.all(appPadding + 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.flag,
                            color: Colors.amber,
                            size: 30.0,
                          ),
                          Text(
                            '  Brands',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                    ],
                  ),
                ),

                ///  BAR---Recommended For You Section =========
                Bar(
                  first: 'Man',
                  second: 'Women',
                  third: 'Kids',
                  firstIcon: FontAwesomeIcons.male,
                  secondIcon: FontAwesomeIcons.female,
                  thirdIcon: FontAwesomeIcons.child,
                  pageController: _secondpageController,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 60,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _secondpageController,
                    children: <Widget>[
                      Container(
                        child: getProducts(
                          categoryId: 9,
                          categoryName: 'Man',
                        ),
                      ),
                      Container(
                        child: getProducts(
                          categoryId: 10,
                          categoryName: 'Women',
                        ),
                      ),
                      Container(
                        child: getProducts(
                          categoryId: 11,
                          categoryName: 'Kids',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(appPadding + 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.outlined_flag,
                            // color: Colors.amber,
                            size: 30.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'ALL',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: ' Sports',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                AllSportsList(),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> moveToLastScreen() {
    return null;
  }
}

class Alert extends StatelessWidget {
  const Alert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(" Welcome"),
      content: SizedBox(
        height: 40.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('don\'t have an account ?'),
            Row(
              children: <Widget>[
                InkWell(
                  child: Text(
                    'Sign in  ',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.teal),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new LoginScreen()));
                  },
                ),
                Text('or  '),
                InkWell(
                  child: Text(
                    'Sign up ',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.teal),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new LoginScreen()));
                  },
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          child: Text('Close'),
        )
      ],
    );
  }
}
