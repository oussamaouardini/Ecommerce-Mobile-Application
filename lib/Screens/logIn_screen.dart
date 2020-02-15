import 'package:flutter/material.dart';
import 'package:pfe/Screens/Click_Product.dart';
import 'package:pfe/api/authentication.dart';
import 'package:pfe/custom_widgets.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final product_details_name;
  final product_id ;
  final productReviewCount ;

  final product_details_price;

  final product_details_picture;

  final product_details_oldPrice;
  final product_description;


  Login({this.product_details_name, this.product_id, this.product_details_price,
      this.product_details_picture, this.product_details_oldPrice,
      this.product_description,this.productReviewCount});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Sign In ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32.0),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          'Login to continue to your account ',
                          style: TextStyle(
                            //  fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: Colors.white),
                                )),
                            validator: (v) {
//                  if (v.isEmpty) {
//                    return 'input required';
//                  } else if(!EmailValidator.validate(v)){
//                    return "Email invalid";
//                  }else{
//                    return null ;
//                  }
                              if (v.isEmpty) {
                                return 'input required';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (v) {
                              // model user.name = v
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            //  controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: Colors.white),
                                )),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'input required';
                              } else if (v.trim().length < 6) {
                                return 'this passwordis too short';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Row(
                            children: <Widget>[
                              Text('Don\'t have an account ?'),
                              FlatButton(onPressed: () {
                                // TODO :: sent it to sign up Screen
                              }, child: Text('Sign Up'))
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: _loading != true ? Colors.blueAccent : Colors.grey
                            ),
                            height: 50.0,
                            child: PrimaryButton(
                              onTap: _loading != true ? () {
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  setState(() {
                                    _loading = true ;
                                  });
                                  _loginUserr();
                                } else {
                                }

                              } :null  ,
                              child:  _loading != true ? Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500),
                              ):CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
  _loginUserr() async{

    String email = _emailController.text;
    String password = _passwordController.text;
    User user = await authentication.login(email, password);
    if(user.userId != null){
      setState(() {
        _loading = false ;
      });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool('login', true);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> new Product_details(
        product_id: widget.product_id,
        product_details_name: widget.product_details_name,
        product_description: widget.product_description,
        product_details_picture: widget.product_details_picture,
        product_details_price: widget.product_details_price,
        product_details_oldPrice: widget.product_details_oldPrice,
        productReviewCount: widget.productReviewCount,
      ) ));
    }else{
      setState(() {
        _loading = false ;
      });
    }

  }

}



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sign In ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Login to continue to your account ',
                      style: TextStyle(
                          //  fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.white),
                            )),
                        validator: (v) {
//                  if (v.isEmpty) {
//                    return 'input required';
//                  } else if(!EmailValidator.validate(v)){
//                    return "Email invalid";
//                  }else{
//                    return null ;
//                  }
                          if (v.isEmpty) {
                            return 'input required';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (v) {
                          // model user.name = v
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        //  controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.white),
                            )),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input required';
                          } else if (v.trim().length < 6) {
                            return 'this passwordis too short';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Text('Don\'t have an account ?'),
                          FlatButton(onPressed: () {
                            // TODO :: sent it to sign up Screen
                          }, child: Text('Sign Up'))
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: _loading != true ? Colors.blueAccent : Colors.grey
                        ),
                        height: 50.0,
                        child: PrimaryButton(
                          onTap: _loading != true ? () {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              setState(() {
                                _loading = true ;
                              });
                              _loginUser();
                            } else {
                            }

                          } :null  ,
                          child:  _loading != true ? Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                          ):CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
    ));
  }

  _loginUser() async{

    String email = _emailController.text;
    String password = _passwordController.text;
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

class PrimaryButton extends StatelessWidget {
  final Widget child;

  final Function onTap;

  const PrimaryButton({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 15.0,
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(child: child),
      ),
    );
  }
}
