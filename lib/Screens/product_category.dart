import 'package:flutter/material.dart';
import 'package:pfe/Component/List_View_Card.dart';
import 'package:pfe/api/cart_api.dart';
import 'package:pfe/custom_widgets.dart';
import 'Home.dart';
import 'package:pfe/cart/cart.dart';
import 'package:pfe/general_config/functions.dart';
import 'package:pfe/general_config/size_config.dart';
import 'package:pfe/Screens/Click_Product.dart';
const appBarColor = Color(0xFF01B2C4);
class ProductCategory extends StatefulWidget {
  final categoryId ;
  final categoryName ;
  ProductCategory({this.categoryId,this.categoryName});
  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {

  bool isLoading = false ;
  ProductApi productApi = ProductApi();

  dynamic total ;

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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomeScreen()));
            },),
        ),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body:Container(
        child:(isLoading == false) ? FutureBuilder(
            future: productApi.fetchProductsGategory(widget.categoryId) ,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
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
                          itemCount:snapShot.data.length ,
                          itemBuilder: (BuildContext context , int position){
                            return _drawProduct(snapShot.data[position]);
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
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) async {
            functions.route_bottom_bar(index, context);
          },
          items: [
            TitledNavigationBarItem(title: 'Home', icon: Icons.home),
            TitledNavigationBarItem(title: 'Search', icon: Icons.search),
            TitledNavigationBarItem(title: 'Favorite', icon: Icons.favorite),
            TitledNavigationBarItem(title: 'Orders', icon: Icons.shopping_cart),
            TitledNavigationBarItem(title: 'Profile', icon: Icons.person_outline),
          ]
      )

    );
  }

  Widget _showLoading(){
    return Container(
      child:Center(
        child: CircularProgressIndicator(),
      ) ,
    );
  }


  Widget drawProduct(Product product,BuildContext context){
    SizeConfig().init(context);
    return Padding(
        padding: const EdgeInsets.only(left:8.0),
      child: InkWell(
        child: Container(
          height: SizeConfig.blockSizeVertical * 15,
          decoration: BoxDecoration(

          ),
          child: Card(
            child: ListTile(
                leading: Image.asset('images/IMG_1266.JPG',),
                title: Text(product.product_title),
                subtitle: Text(
                    '\$'+product.product_price.toString()
                ),
              //  trailing: ,
                // isThreeLine: true,
              ),

          ),
        ),
      ),
    );
  }
  Widget _drawProduct(Product product){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Product_details(
              product_details_name: product.product_title,
              product_details_picture: product.featured_image(),
              product_details_price: product.product_price,
              product_details_oldPrice: product.product_price,
              product_description: product.product_description,
              product_id: product.product_id,
            )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 90,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(product.product_title,style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0
                              ),),
                              SizedBox(height: 5.0,),
                              Text('\$ '+product.product_price.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
//              Row(
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      IconButton(icon: Icon(Icons.play_arrow),
//                          onPressed: () async{
//                            setState(() {
//                              isLoading = true ;
//                            });
//                          //  await likeApi.removeUserLike(user_id, like.product.product_id);
//                            setState(() {
//                              isLoading = false ;
//                            });
//
//                          }),
//
//                    ],
//                  )
//                ],
//              )
            ],
          ),
        ),
      ),
    );
  }


}
