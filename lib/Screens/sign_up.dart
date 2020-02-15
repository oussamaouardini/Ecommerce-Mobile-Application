import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/painting.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/log.dart';
import 'package:pfe/api/authentication.dart';
import 'package:pfe/constants.dart';
import 'package:pfe/customer/user.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _backButton() {
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

  Widget _entryField(String title,TextEditingController textController, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              obscureText: isPassword,
              controller: textController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            validator: (v){
              if (v.isEmpty) {
                return 'input required';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }


  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*2)),
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
              colors: [Constant.appBarColor, Colors.white])),
      child: InkWell(
          onTap:_loading != true ? (){
            if(key.currentState.validate()){
              key.currentState.save();
              setState(() {
                _loading = true ;
              });
              signUpUser();
            }else{
              print("is not validate");
            }
          } : null,
        child: _loading != true ? Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ):CircularProgressIndicator(),
      ),
    );



  }

  signUpUser() async{
    Authentication authentication = Authentication();
    String email = emailController.text;
    String password = passwordController.text;
    String first_name = firstNameController.text;
    String last_name = lastNameController.text;
    User user = await authentication.register(first_name,last_name,email,password);
    if(user == null){
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


  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Constant.appBarColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("First Name",firstNameController),
        _entryField("Last Name",lastNameController),
        _entryField("Email",emailController),
        _entryField("Password",passwordController ,isPassword: true),
        _entryField("Confirm Password",confirmPasswordController ,isPassword: true),
      ],
    );
  }


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final  key = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child:Container(
                height: MediaQuery.of(context).size.height,
                child:Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: (SizeConfig.blockSizeVertical*0.5).toInt() ,
                            child: SizedBox(
                              child: Image.network(
                                  "https://cdn.discordapp.com/attachments/671407027871940609/675722336691027978/logo.png",color: Colors.black,),
                            ),
                          ),
                         // _emailPasswordWidget(),
                          Form(
                            key: key,
                              child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'First Name',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (v){
                                        if (v.isEmpty) {
                                          return 'input required';
                                        } else {
                                          return null;
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
                                      'Last Name',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (v){
                                        print(v.toString());
                                        if (v.isEmpty) {
                                          return 'input required';
                                        } else {
                                          return null;
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
                                      'Email ',
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
                              Container(
                                margin: EdgeInsets.symmetric(vertical: (SizeConfig.blockSizeHorizontal*3)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Confirm Password',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: confirmPasswordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true),
                                      validator: (v){
                                        if (v.isEmpty) {
                                          return 'input required';
                                        } else if(v.trim().length < 6) {
                                          return 'this password is too short';
                                        }else if(v.trim()!= passwordController.text.trim()){
                                          return 'Password not match' ;
                                        }else{
                                          return null ;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          _submitButton(),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _loginAccountLabel(),
                    ),
                    Positioned(top: (SizeConfig.blockSizeVertical*1), left: 0, child: _backButton()),
                    Positioned(
                        top: -MediaQuery.of(context).size.height * .25,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: BezierContainer())
                  ],
                ),
              )
          ),
        )
    );
  }
}


class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / 3.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Constant.appBarColor,Colors.white]
                  )
              ),
            ),
          ),
        )
    );
  }
}






class ClipPainter extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height );
    path.lineTo(size.width , height);
    path.lineTo(size.width , 0);

    /// [Top Left corner]
    var secondControlPoint =  Offset(0  ,0);
    var secondEndPoint = Offset(width * .2  , height *.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);



    /// [Left Middle]
    var fifthControlPoint =  Offset(width * .3  ,height * .5);
    var fiftEndPoint = Offset(  width * .23, height *.6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fiftEndPoint.dx, fiftEndPoint.dy);


    /// [Bottom Left corner]
    var thirdControlPoint =  Offset(0  ,height);
    var thirdEndPoint = Offset(width , height  );
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);



    path.lineTo(0, size.height  );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }


}