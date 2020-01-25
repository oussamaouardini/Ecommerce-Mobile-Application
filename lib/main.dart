import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Component/gridViewList.dart';
import 'package:pfe/api/helpers_api.dart';
import 'package:pfe/product/product.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: home_screen(),
 // home: GeneralShop(),

));


class GeneralShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generale Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Authentication authentication = Authentication();
  // ProductApi productApi = ProductApi();
  HelpersApi helpersApi = HelpersApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General Shop"),
      ),
      body: FutureBuilder(
         future: helpersApi.fetchStates(1,1),
       //   future: helpersApi.fetchCategories(1),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.none:
                __error('no connection!!!');
                break;
              case ConnectionState.waiting:
                __loading();
                break;
              case ConnectionState.active:
                __loading();
                break;
              case ConnectionState.done:
                if (snapShot.hasError) {
                  return __error(snapShot.error.toString());
                } else {
                  return ListView.builder(
                      itemCount: snapShot.data.length,
                      itemBuilder: (BuildContext context , int position){
                        return __drawCard(snapShot.data[position]);
                      }
                  );
                }
                break;
            }
            return Container();
          }),
    );
  }

  __drawCard( dynamic item ){
    return Card(
      child: Padding(padding: EdgeInsets.all(16.0),
        child: Text(item.state_name),
      ),
    );
  }

  __error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  __loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  __drawProduct(Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(product.product_title),
            Image(
              image: product.images.length > 0
                  ? NetworkImage(product.images[0])
                  : NetworkImage(
                  'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'),
            )
          ],
        ),
      ),
    );
  }


}
