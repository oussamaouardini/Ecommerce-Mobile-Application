import 'package:flutter/material.dart';
import 'package:pfe/Component/List_View_Card.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:pfe/custom_widgets.dart';
import 'Home.dart';
import 'package:pfe/cart/cart.dart';

const appBarColor = Color(0xFF01B2C4);
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartApi cartApi = CartApi() ;
  bool isloading = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBarColor,

        title: ListTile(
          title: InkWell(child: Text('Shoping Cart',style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          ),),
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new home_screen()));
          },),
        ),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body:Container(
        child:(isloading == false) ? FutureBuilder(
            future: cartApi.fetchCart(),
            // future: helpersApi.fetchStates(1,1),
            // future: helpersApi.fetchCategories(1),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
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
                      return ListView.builder(
                        itemCount:snapShot.data.cartItems.length ,
                          itemBuilder: (BuildContext context , int position){
                          return _drawProduct(snapShot.data.cartItems[position]);
                          }
                          );
                    }else{
                      return Text("NO data");
                    }
                  }
                  break;
              }
              return Container();
            }): _showLoading() ,
      ) ,
      bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(child: ListTile(
                title: Text('Total :'),
                subtitle: Text("\$230"),
              )),
              Expanded(
                  child: MaterialButton(onPressed: (){},
                    child: Text('check out',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),),
                    color: appBarColor,
                  )
              ),
            ],
          )
      ),

    );
  }

  Widget _showLoading(){
    return Container(
      child:Center(
        child: CircularProgressIndicator(),
      ) ,
    );
  }

  Widget _drawProduct(CartItem cartItem){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                  //  color: Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                     // image: NetworkImage(cartItem.product.featured_image()),
                    image: AssetImage(
                      'images/IMG_1266.JPG',

                    ),
                    )
                  ),
                ),
                Text(cartItem.product.product_title)
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.add_circle_outline),
                  onPressed: () async{
                setState(() {
                  isloading = true ;
                });
                await cartApi.addProductTocart(cartItem.product.product_id, 1);
                setState(() {
                  isloading = false ;
                });


              }),
              Text(cartItem.quantity.toString()),
              IconButton(icon: Icon(Icons.remove_circle_outline),
                  onPressed: () async{
                    setState(() {
                      isloading = true ;
                    });
                    await cartApi.RemoveProductFromCart(cartItem.product.product_id, 1);
                    setState(() {
                      isloading = false ;
                    });
              }),
            ],
          )
        ],
      ),
    );
  }

}
