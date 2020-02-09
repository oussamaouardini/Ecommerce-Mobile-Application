import 'package:flutter/material.dart';
import 'package:pfe/Screens/filter_product.dart';
import 'package:pfe/Screens/log_out.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/user/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:meta/meta.dart';
///*****************************  ******************************************************************************************


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
    'Men\'s Sweater': false,
    'Men\'s Jacket': false,
    'Men\'s Footware': false,
    'Men\'s Pants': false,
    'Men\'s T-Shirts': false,
    'Men\'s Sneakers': false,
  };
  Map<String, bool> categoriesWomen = {
    'Women\'s Sweater': false,
    'Women\'s Jacket': false,
    'Women\'s Footware': false,
    'Women\'s Pants': false,
    'Women\'s T-Shirts': false,
    'Women\'s Sneakers': false,
  };
  Map<String, bool> categoriesChild = {
    'Child\'s Sweater': false,
    'Child\'s Jacket': false,
    'Child\'s Footware': false,
    'Child\'s Pants': false,
    'Child\'s T-Shirts': false,
    'Child\'s Sneakers': false,
  };
  Map<String, bool> brands = {
    'Adidas': false,
    'Nike': false,
    'Puma': false,
    'Reebook': false,
  };
  Map<String, bool> colors = {
    'Blue': false,
    'Green': false,
    'Blue Grey': false,
    'Cyan': false,
  };
  Map<String, bool> size = {
    'Extra Small': false,
    'Small': false,
    'Medium': false,
    'Large': false,
    'Extra Large': false,
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
                    Container(
                      child : ExpansionTile(
                        initiallyExpanded: false,
                        title: Text('Colors'),
                        children: colors.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: colors[key],
                            onChanged: (bool value) {
                              setState(() {
                                colors[key] = value;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      child : ExpansionTile(
                        initiallyExpanded: false,
                        title: Text('Size'),
                        children: size.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: size[key],
                            onChanged: (bool value) {
                              setState(() {
                                size[key] = value;
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
                    this.filter(size, tab);
                    this.filter(colors, tab);
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
