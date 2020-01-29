import 'package:flutter/material.dart';
import 'package:pfe/api/like_api.dart';
import 'package:pfe/like/like.dart';




class Favorite extends StatefulWidget {
  final user_id ;
  Favorite({this.user_id});
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  static int user_id ;
  bool isloading = false ;
  LikeApi likeApi = LikeApi() ;
  @override
  Widget build(BuildContext context) {
    user_id = widget.user_id ;
    return Scaffold(
      appBar: AppBar(),
      body: (isloading == false) ? FutureBuilder(
          future: likeApi.fetchUserLikes(user_id),
          builder: (BuildContext context, AsyncSnapshot<List<Like>> snapShot) {
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
          }): _showLoading()
    );
  }

  Widget _showLoading(){
    return Container(
      child:Center(
        child: CircularProgressIndicator(),
      ) ,
    );
  }

  Widget __drawProduct(Like like){
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 60.0),
            title: Text('ff'),
            subtitle: Text('\$ '+like.product.product_price.toString()),
            trailing: Column(
              children: <Widget>[

                Expanded(child: IconButton(
                  icon: Icon(Icons.favorite ,color: Colors.red, ),
                  onPressed: (){},
                ))

              ],
            ),
            // isThreeLine: true,
          ),

        ],
      ),
    );
  }


  Widget _drawProduct(Like like){
    return Padding(
      padding: const EdgeInsets.only(left:8.0,top: 8.0),
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
                          Text(like.product.product_title),
                          SizedBox(height: 5.0,),
                          Text('\$ '+like.product.product_price.toString())
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.favorite,color: Colors.red,),
                      onPressed: () async{
                        setState(() {
                          isloading = true ;
                        });
                        await likeApi.removeUserLike(user_id, like.product.product_id);
                        setState(() {
                          isloading = false ;
                        });

                      }),

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
