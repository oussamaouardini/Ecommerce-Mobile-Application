import 'package:flutter/material.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/favorite_screen.dart';
import 'package:pfe/Screens/filter_product.dart';
import 'package:pfe/Screens/log_out.dart';
import 'package:pfe/Screens/sign_up.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/user/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:meta/meta.dart';
///*****************************  ******************************************************************************************
import 'package:pfe/cart/cart.dart' as cart;
import 'package:pfe/Screens/shoping_cart.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal*80,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/f/fc/Lineas_de_nasca.jpg'),
                    fit: BoxFit.cover)),
            child: Text("Header"),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}




class Drawerr extends StatefulWidget {

//  final email ;
//  final name ;
//
//
//  Drawerr(this.email, this.name);

  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {

  static SharedPreferences pref ;
  static int userId ;
  static String apiToken ;
  checkUser() async{
    pref = await SharedPreferences.getInstance() ;
    userId = pref.getInt('user_id');
    apiToken = pref.get('api_token');
  }

  UserApi userApi = UserApi();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkUser();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Color(0XFF191919),
            child: ((apiToken == null) && (userId == null) ) ? _drawNoUser():FutureBuilder(
                future: userApi.fetchUser(userId),
                builder: (BuildContext context, AsyncSnapshot<User> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      if (snapShot.hasError) {
                        return Text('Error');
                      } else {
                        if(snapShot.hasData){
                          return _drawUser(snapShot.data);
                        }else{
                          return Text("NO data");
                        }
                      }
                      break;
                  }
                  return Container();
                }
            ) ,
          ),
          Flexible(
            child:Container(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen() ));
                    },
                    child: ListTile(
                      title: Text("Home"),
                      leading: Icon(
                        Icons.home,
                        // color: Colors.red,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      CartApi cartApi = CartApi();

                      SharedPreferences pref = await SharedPreferences.getInstance();
                      int userId = pref.getInt('user_id');
                      String apiToken = pref.getString('api_token');
                      if ((userId != null) || (apiToken != null)) {
                        cart.Cart car = await cartApi.fetchCart();
                        if(car == null){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(msg:"your Shopping card is empty");
                              });
                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Cart(car.total)));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Alert();
                            });
                      }
                    },
                    child: ListTile(
                      title: Text("My orders"),
                      leading: Icon(
                        Icons.shopping_basket ,
                        //  color: Colors.red,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      int userId = pref.getInt('user_id');
                      String apiToken = pref.getString('api_token');
                      if ((userId != null) || (apiToken != null)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Favorite(
                                  userId: userId,
                                )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Alert();
                            });
                      }
                    },
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
                    onTap: () async {
                      UserApi userApi = UserApi();
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      int userId = pref.getInt('user_id');
                      String apiToken = pref.getString('api_token');
                      if ((userId != null) || (apiToken != null)) {
                        User user = await userApi.fetchUser(userId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                new Account(
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: user.email,
                                  password: user.password,
                                  memberSince: user.memberSince,
                                  mobile: user.mobile,
                                  shippingAddress: user.shippingAddress,
                                )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Alert();
                            });
                      }
                    },
                    child: ListTile(
                      title: Text("Settings"),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    child: ((userId != null) && (apiToken != null) ) ? InkWell(
                      onTap: () async{
                        if((userId == null)||( apiToken == null )){

                        }else{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('api_token');
                          prefs.remove('user_id');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LogOut()  ));
                        }

                      },
                      child: ListTile(
                        title:  Text("Log Out"),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.blue,
                        ),
                      ),
                    ):null,
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
          )


        ],

      ),
    );
  }



  Widget _drawUser( User user ){
    return UserAccountsDrawerHeader(
      accountName: Text( user.firstName +' '+user.lastName ),
      accountEmail: Text(user.email),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
      ),
      decoration: BoxDecoration(color:Color(0XFF191919)),
    );
  }
  Widget _drawNoUser(){
    return UserAccountsDrawerHeader(
      accountName: Text( 'Welcome '),
      accountEmail: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text :'Sign in   ',style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text :'or   '),
              TextSpan(text :'Sign up ',style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
      ),
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
    );
  }

}





class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String foos = 'One';
 // final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Clear Results"),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clear",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0)),
                  ),
                  onTap:(){

                  },
                )
              ],
            ),
            Divider(),
            Flexible(
              child: ExpansionTile(
                  title: new Text(this.foos),
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                  children: <Widget>[
                    new ListTile(
                      title: const Text('One'),
                      onTap: () {
                        setState(() {
                          this.foos = 'One';
                        });
                      },
                    ),
                    new ListTile(
                      title: const Text('Two'),
                      onTap: () {
                        setState(() {
                          this.foos = 'Two';
                        });
                      },
                    ),
                    new ListTile(
                      title: const Text('Three'),
                      onTap: () {
                        setState(() {
                          this.foos = 'Three';
                        });
                      },
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ExpansionTileSample extends StatefulWidget {
  @override
  ExpansionTileSampleState createState() => new ExpansionTileSampleState();
}

class ExpansionTileSampleState extends State<ExpansionTileSample> {


  Map<String, bool> values = {
    'Sweater': true,
    'Jacket': false,
  };
  Map<String, bool> categoriesMen = {
    'menSweater': false,
    'menFootwar': false,
    'menPants': false,
    'menT-Shirts': false,
    'menSneakers': false,
  };
  Map<String, bool> categoriesWomen = {
    'womenSweater': false,
    'womenFootwar': false,
    'womenPants': false,
    'womenT-Shirts': false,
    'womenSneakers': false,
  };
  Map<String, bool> categoriesChild = {
    'childSweater': false,
    'childFootwar': false,
    'childPants': false,
    'childT-Shirts': false,
    'childSneakers': false,
  };
  Map<String, bool> brands = {
    'Adidas': false,
    'Nike': false,
    'Puma': false,
    'Reebook': false,
  };
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clear Results"),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Clear",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                    ),
                    onTap:(){

                      setState(() {
                        categoriesMen = {
                          'menSweater': false,
                          'menFootwar': false,
                          'menPants': false,
                          'menT-Shirts': false,
                          'menSneakers': false,
                        };
                        categoriesWomen = {
                          'womenSweater': false,
                          'womenFootwar': false,
                          'womenPants': false,
                          'womenT-Shirts': false,
                          'womenSneakers': false,
                        };
                        categoriesChild = {
                          'childSweater': false,
                          'childFootwar': false,
                          'childPants': false,
                          'childT-Shirts': false,
                          'childSneakers': false,
                        };
                        brands = {
                          'Adidas': false,
                          'Nike': false,
                          'Puma': false,
                          'Reebook': false,
                        };
                      });
                       categoriesMen = {
                        'menSweater': false,
                        'menFootwar': false,
                        'menPants': false,
                        'menT-Shirts': false,
                        'menSneakers': false,
                      };
                       categoriesWomen = {
                        'womenSweater': false,
                        'womenFootwar': false,
                        'womenPants': false,
                        'womenT-Shirts': false,
                        'womenSneakers': false,
                      };
                       categoriesChild = {
                        'childSweater': false,
                        'childFootwar': false,
                        'childPants': false,
                        'childT-Shirts': false,
                        'childSneakers': false,
                      };
                       brands = {
                        'Adidas': false,
                        'Nike': false,
                        'Puma': false,
                        'Reebook': false,
                      };
                    },
                  )
                ],
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child : ExpansionTile(
                        initiallyExpanded: true,
                        title: Text('Categories'),
                        children: <Widget>[
                          Container(
                            child: ExpansionTile(
                              initiallyExpanded: false,
                              title: Text('Man'),
                              children: categoriesMen.keys.map((String key) {
                                return new CheckboxListTile(
                                  title: new Text(key),
                                  value: categoriesMen[key],
                                  onChanged: (bool value) {
                                    setState(() {
                                      categoriesMen[key] = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            child: ExpansionTile(
                              title: Text('Woman'),
                              children: categoriesWomen.keys.map((String key) {
                                return new CheckboxListTile(
                                  title: new Text(key),
                                  value: categoriesWomen[key],
                                  onChanged: (bool value) {
                                    setState(() {
                                      categoriesWomen[key] = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            child: ExpansionTile(
                              title: Text('Child'),
                              children: categoriesChild.keys.map((String key) {
                                return new CheckboxListTile(
                                  title: new Text(key),
                                  value: categoriesChild[key],
                                  onChanged: (bool value) {
                                    setState(() {
                                      categoriesChild[key] = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child : ExpansionTile(
                        initiallyExpanded: false,
                        title: Text('Brands'),
                        children: brands.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: brands[key],
                            onChanged: (bool value) {
                              setState(() {
                                brands[key] = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    List<dynamic> tab = [];

                    this.filter(categoriesMen, tab);
                    this.filter(categoriesWomen, tab);
                    this.filter(categoriesChild, tab);
                    this.filter(brands, tab);

                  HelpersApi helperApi = HelpersApi();

                  helperApi.filter(tab);


                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new FilterProduct(tab)));



                  },
                  splashColor: Colors.blue,
                  highlightColor: Colors.blue,
                  child: Container(
                    height: 36,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Center(
                      child: Text("Apply Filters"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void filter(Map<String, bool> category , List<dynamic> tabb ){
    for(int i = 0 ; i< category.keys.toList().length ; i++   ){
      if(category.values.toList().elementAt(i) == true ){
        tabb.add(category.keys.toList().elementAt(i));
      }
    }
  }

}



class Dialog extends StatelessWidget {
  final String msg ;
  const Dialog({
    Key key,
    this.msg
  }) ;

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
            Text('${this.msg.toString()}?'),
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