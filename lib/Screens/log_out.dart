import 'package:flutter/material.dart';

import 'package:pfe/Screens/Home.dart';


class logout extends StatefulWidget {
  @override
  _logoutState createState() => _logoutState();
}

class _logoutState extends State<logout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
        (){
          Navigator.push(context, new MaterialPageRoute(builder: (context)=> new HomeScreen() ));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlutterLogo(
              size: 100.0,
            ),

            Column(
              children: <Widget>[
                CircularProgressIndicator(
                 // backgroundColor: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Loggin out...",style: TextStyle(

                    color: Colors.cyan,
                    fontSize: 20.0,

                  ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
