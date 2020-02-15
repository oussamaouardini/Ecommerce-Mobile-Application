import 'package:flutter/material.dart';
import 'package:pfe/Screens/Home.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF191919),
      body: Container(
        width: double.infinity,
        color: Color(0XFF191919),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Image.network(
                  "https://cdn.discordapp.com/attachments/671407027871940609/675722336691027978/logo.png"),
            ),
            Column(
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Loggin out...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
