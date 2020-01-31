import 'package:flutter/material.dart';
import 'package:pfe/Screens/log_out.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/user/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/general_config/size_config.dart';
///*****************************  ******************************************************************************************




class drawerr extends StatefulWidget {
  @override
  _drawerrState createState() => _drawerrState();
}

class _drawerrState extends State<drawerr> {

  static SharedPreferences pref ;
  static int userId ;
  static String api_token ;
  checkUser() async{
    pref = await SharedPreferences.getInstance() ;
    userId = pref.getInt('user_id');
    api_token = pref.get('api_token');
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
    setState(() {
      checkUser();
      print(userId.toString());
      print(api_token.toString());
    });
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: ((api_token == null) && (userId == null) ) ? UserAccountsDrawerHeader(
              accountName: Text("Welcome"),
              accountEmail: InkWell(child: Text("Enter your account"),onTap: (){
                // TODO: send to login
              },),
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
            ):FutureBuilder(

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
                    child: ((userId != null) && (api_token != null) ) ? InkWell(
                      onTap: () async{
                        if((userId == null)||( api_token == null )){

                        }else{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('api_token');
                          prefs.remove('user_id');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> logout()  ));
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
      accountName: Text( user.first_name +''+user.last_name ),
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
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

}





