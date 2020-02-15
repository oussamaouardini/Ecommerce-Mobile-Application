import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pfe/Screens/Click_Product.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/sign_up.dart';
import 'package:pfe/api/authentication.dart';
import 'package:pfe/constants.dart';
import 'package:pfe/customer/user.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  final productDetailsName;
  final productId ;
  final productReviewCount ;

  final productDetailsPrice;

  final productDetailsPicture;

  final productDetailsOldPrice;
  final productDescription;


  LoginPage({this.productDetailsName, this.productId, this.productReviewCount,
      this.productDetailsPrice, this.productDetailsPicture,
      this.productDetailsOldPrice, this.productDescription});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final  _key = GlobalKey<FormState>();
  bool _loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: (SizeConfig.blockSizeVertical*0.5).toInt() ,
                          child: SizedBox(
                            child: Image.network(
                              "https://cdn.discordapp.com/attachments/671407027871940609/675722336691027978/logo.png",color: Colors.black,),
                          ),
                        ),
                        // _emailPasswordWidget(),
                        Form(
                            key: _key ,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Email',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                        validator: (v){
                                          if (v.isEmpty) {
                                            return 'input required';
                                          } else if(!EmailValidator.validate(v)){
                                            return "Email invalid";
                                          }else{
                                            return null ;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Password',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                        validator: (v){
                                          if (v.isEmpty) {
                                            return 'input required';
                                          } else if(v.trim().length < 6) {
                                            return 'this passwordis too short';
                                          }else{
                                            return null ;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap:  (){
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              setState(() {
                                _loading = true ;
                              });
                              _loginUser();
                            } else {
                            }

                          }  ,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [ Colors.white,Constant.appBarColor])),
                            child: _loading != true ? Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ):CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _facebookButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(context),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton(context)),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )
        )
    );
  }
  _loginUser() async{

    String email = emailController.text;
    String password = passwordController.text;
    User user = await authentication.login(email, password);
    if(user.userId != null){
      setState(() {
        _loading = false ;
      });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('login', true);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> new Product_details(
        product_id: widget.productId,
        product_details_name: widget.productDetailsName,
        product_description: widget.productDescription,
        product_details_picture: widget.productDetailsPicture,
        product_details_price: widget.productDetailsPrice,
        product_details_oldPrice: widget.productDetailsOldPrice,
        productReviewCount: widget.productReviewCount,
      ) ));
    }else{
      setState(() {
        _loading = false ;
      });
    }

  }
}


Widget _backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}



Widget _submitButton(BuildContext context) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ Colors.white,Constant.appBarColor])),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget _divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget _facebookButton() {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff1959a9),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text('f',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400)),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff2872ba),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text('Log in with Facebook',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    ),
  );
}

Widget _createAccountLabel(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t have an account ?',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text(
            'Register',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    ),
  );
}

Widget _title() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'd',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xffe46b10),
        ),
        children: [
          TextSpan(
            text: 'ev',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'rnz',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
        ]),
  );
}




class LogIn extends StatefulWidget {
  LogIn({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final  _key = GlobalKey<FormState>();
  bool _loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: (SizeConfig.blockSizeVertical*0.5).toInt() ,
                          child: SizedBox(
                            child: Image.network(
                              "https://cdn.discordapp.com/attachments/671407027871940609/675722336691027978/logo.png",color: Colors.black,),
                          ),
                        ),
                        // _emailPasswordWidget(),
                        Form(
                            key: _key ,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Email',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                        validator: (v){
                                          if (v.isEmpty) {
                                            return 'input required';
                                          } else if(!EmailValidator.validate(v)){
                                            return "Email invalid";
                                          }else{
                                            return null ;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Password',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true),
                                        validator: (v){
                                          if (v.isEmpty) {
                                            return 'input required';
                                          } else if(v.trim().length < 6) {
                                            return 'this passwordis too short';
                                          }else{
                                            return null ;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap:  (){
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              setState(() {
                                _loading = true ;
                              });
                              _loginUser();
                            } else {
                            }

                          }  ,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [ Colors.white,Constant.appBarColor])),
                            child: _loading != true ? Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ):CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _facebookButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(context),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton(context)),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )
        )
    );
  }
  _loginUser() async{

    String email = emailController.text;
    String password = passwordController.text;
    User user = await authentication.login(email, password);

    if(user == null){
      print("null");
      setState(() {
        _loading = false ;
      });
    }else if(user.userId != null){
      setState(() {
        _loading = false ;
      });
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new HomeScreen() ));
    }else{
      setState(() {
        _loading = false ;
      });
    }

  }
}