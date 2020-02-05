import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/Component/horisontale_list.dart';
import 'package:pfe/Screens/Home.dart';
import 'package:pfe/Screens/logIn_screen.dart';
import 'package:pfe/Screens/product_raiting.dart';
import 'package:pfe/api/like_api.dart';
import 'package:pfe/api/reviews.dart';
import 'package:pfe/like/like.dart';
import 'package:pfe/review/product_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:pfe/api/cart_api.dart';
double baseHeight = 640.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

List<String> sizeNumlist = [
  "7",
  "8",
  "9",
  "10",
];
List<String> sizeCloathlist = [
  "M",
  "L",
  "XL",
  "XXL",
];

List<Color> colors = [
  Color(0xFFF9362E),
  Color(0xFF003CFF),
  Color(0xFFFFB73A),
  Color(0xFF3AFFFF),
  Color(0xFF1AD12C),
  Color(0xFFD66400),
];

String desc =
    "Get maximum support, comfort and a refreshed look with these adidas energy cloud shoes for men comes wit a classic style."
    "Boost your running comfort to the next level with this supportive shoe Synthetic upper with FITFRAME midfoot cage for a locked-down fit and feel"
    "Lace-up closure Cushioned footbed CLOUDFOAM midsole provides responsive padding Durable ADIWEAR™ rubber sole.";


const appBarColor = Color(0xFF01B2C4);

class Product_details extends StatefulWidget {
  final product_details_name;
  final product_id ;

  final product_details_price;

  final product_details_picture;

  final product_details_oldPrice;
  final product_description;
  final productReviewCount ;
  final productCategory ;

  Product_details(
      {this.product_details_name,
        this.product_details_picture,
        this.product_details_oldPrice,
        this.product_details_price,this.product_description,
        this.product_id,
        this.productReviewCount,
        this.productCategory
      });



  static String id = 'Product_details';

  @override
  _Product_detailsState createState() => _Product_detailsState();
}

class Post extends StatefulWidget{
  final id , productReviewCount;
  final product_name  ,product_description , product_picture  ;
  final  product_price , product_old ;
  final productCategory ;

  Post({this.id,this.product_name,this.product_description,this.product_picture,this.product_price,this.product_old,this.productReviewCount,this.productCategory});

  @override
  PostState createState() => new PostState();
}

class PostState extends State<Post>{

  bool liked = false;

  __llikes() async {

    pref = await SharedPreferences.getInstance() ;
    userId = pref.getInt('user_id');
    api_token = pref.get('api_token');
    if(userId!=null){

      List<Like> userLikes = [] ;
      userLikes = await _likeApi.fetchUserLikes(userId);
      var temp = false ;
      int counter = 0;
      for(int i=0;i<userLikes.length ; i++){
        if(widget.id == userLikes[i].product.product_id ){
          break;
        }
        counter++;
      }
      if(counter == userLikes.length)
      {
        setState(() {
          liked = false;
        });
      }
      else
      {setState(() {
        liked = true;
      });
      }
    }
  }
  __pressed() async{

    if(userId!=null){
      if (liked == true) {
        await _likeApi.removeUserLike(userId, widget.id);
      } else {
        await _likeApi.addUserLike(userId, widget.id);
      }
      setState((){
        liked = !liked;
      });
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login(product_id: widget.id,
      product_description: widget.product_description,product_details_name: widget.product_name,product_details_price: widget.product_price,
        product_details_picture: widget.product_picture,product_details_oldPrice: widget.product_old,productReviewCount: widget.productReviewCount,
      )));
    }


  }

  LikeApi _likeApi = LikeApi() ;


  static SharedPreferences pref ;
  static int userId ;
  static String api_token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __llikes();
    //print()
  }



  @override
  Widget build (BuildContext context) {

    return Container(
      child: IconButton(
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border,),
        color:  Colors.red,
        onPressed: () => __pressed(),
      )
    );
  }
}

class _Product_detailsState extends State<Product_details> {

  var first_color = Color(0xFF0E397E);
  var second_color = Color(0xFF3CB879);
  var third_color = Color(0xFF363837);
  var fourth_color = Color(0xFF4A8CD6);
  var fifth_color = Color(0xFFE7257E);
  ReviewApi reviewApi = ReviewApi();
  int groupValue;

  bool isExpanded = false;
  bool isExpandedreview = false ;
  int currentSizeIndex = 0;
  int currentColorIndex = 0;
  int _counter = 1;

  void _increase() {
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
      _counter < 1 ? _counter = 1 : _counter = _counter ;
    });
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }
  void _expandReview() {
    setState(() {
      isExpandedreview ? isExpandedreview = false : isExpandedreview = true;
    });
  }

  List<Widget> colorSelector() {
    List<Widget> colorItemList = new List();

    for (var i = 0; i < colors.length; i++) {
      colorItemList
          .add(colorItem(colors[i], i == currentColorIndex, context, () {
        setState(() {
          currentColorIndex = i;
        });
      }));
    }

    return colorItemList;
  }

  CartApi _cartApi = CartApi() ;
  LikeApi _likeApi = LikeApi() ;
  bool isLiked = false;


  static SharedPreferences pref ;
  static int userId ;
  static String api_token ;
  checkliked() async{
    pref = await SharedPreferences.getInstance() ;
    userId = pref.getInt('user_id');
    api_token = pref.get('api_token');
    if(userId!=null){

      List<Like> userLikes = [] ;
      userLikes = await _likeApi.fetchUserLikes(userId);
      var temp = false ;
      for(int i=0;i<userLikes.length ; i++){
        if( widget.product_id == userLikes[i].product.product_id ){
           isLiked = true ;
           temp = true ;
        }
      }
      if((isLiked == true) && (temp == false)){
        isLiked = false ;
      }
    }
  }

   bool _addingToCart = false ;
  bool loading = false ;
  @override
  Widget build(BuildContext context) {
    print(widget.productCategory);
    return WillPopScope(
      onWillPop: (){
        return moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: appBarColor,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            moveToLastScreen();
          }),
          title: InkWell(child: Text('Shoping App'),onTap: (){},),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
        ),
         bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: -1, // Use this to update the Bar giving a position
          onTap: (index){
          },
          items: [
            TitledNavigationBarItem(title: 'Home', icon: Icons.home),
            TitledNavigationBarItem(title: 'Search', icon: Icons.search),
            TitledNavigationBarItem(title: 'Favorite', icon: Icons.favorite),
            TitledNavigationBarItem(title: 'Orders', icon: Icons.shopping_cart),
            TitledNavigationBarItem(title: 'Profile', icon: Icons.person_outline),
          ]
      ),
        body:(loading == false)? ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Image.network(widget.product_details_picture, width: double.infinity, fit: BoxFit.cover) == null ? CircularProgressIndicator():Image.network(widget.product_details_picture, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  left: screenAwareSize(18.0, context),
                  bottom: screenAwareSize(15.0, context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Rating",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenAwareSize(10.0, context),
                              fontFamily: "Montserrat-SemiBold")),
                      SizedBox(
                        height: screenAwareSize(8.0, context),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(Icons.star, color: Colors.amber),
                          SizedBox(
                            width: screenAwareSize(5.0, context),
                          ),
                          Text("4.5", style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold, fontSize: 16.0)),
                          SizedBox(
                            width: screenAwareSize(5.0, context),
                          ),
                          Text('('+widget.productReviewCount.toString()+' People)',
                              style: TextStyle(color: Colors.black, fontSize: 20.0))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),Padding(
              padding: EdgeInsets.only(left: screenAwareSize(18.0, context),top:5.0),
              child: Row(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only( right: 5 ),
                      child: Text(
                        "Product Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                          //   fontSize: screenAwareSize(10.0, context),
                          // fontFamily: "Montserrat-SemiBold"
                        ),
                      ),

                    ),
                  Expanded(child: Divider())
                ],
              ),
            ),
            SizedBox(
              height: screenAwareSize(8.0, context),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(26.0, context),
                  right: screenAwareSize(18.0, context)),
              child: AnimatedCrossFade(
                firstChild: Text(
                  widget.product_description,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                  fontSize: 15.0
                  //    fontSize: screenAwareSize(10.0, context),
                    //  fontFamily: "Montserrat-Medium"
                  ),
                ),
                secondChild: Text(
                  widget.product_description,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                     // fontFamily: "Montserrat-Medium"
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(26.0, context),
                  right: screenAwareSize(18.0, context)),
              child: GestureDetector(
                  onTap: _expand,
                  child: Text(
                    isExpanded ? "less" : "more..",
                    style: TextStyle(
                        color: Color(0xFF01B2C4), fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: screenAwareSize(12.0, context),
            ), Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(15.0, context),
                  right: screenAwareSize(75.0, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Size",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      )
                  ),
                  Text("Quantity",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenAwareSize(20.0, context),
                  right: screenAwareSize(10.0, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: screenAwareSize(38.0, context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: sizeNumlist.map((item) {
                        var index = sizeNumlist.indexOf(item);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSizeIndex = index;
                            });
                          },
                          child:
                          sizeItem(item, index == currentSizeIndex, context),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: screenAwareSize(100.0, context),
                      height: screenAwareSize(30.0, context),
                      decoration: BoxDecoration(
                          color: Color(0xFF525663),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: _decrease,
                              child: Container(
                                height: double.infinity,
                                child: Center(
                                  child: Text("-",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: "Montserrat-Bold")),
                                ),
                              ),
                            ),
                          ),
                          divider(),
                          Flexible(
                            flex: 3,
                            child: Container(
                              height: double.infinity,
                              child: Center(
                                child: Text(_counter.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontFamily: "Montserrat-Bold")),
                              ),
                            ),
                          ),
                          divider(),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: _increase,
                              child: Container(
                                height: double.infinity,
                                child: Center(
                                  child: Text("+",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: "Montserrat-Bold")),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
              child: Row(
                children: <Widget>[
                  Text("Select Color",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      )
                  ),
                  Expanded(child: Divider())
                ],
              )
            ),
            SizedBox(
              height: screenAwareSize(8.0, context),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: screenAwareSize(20.0, context)),
              height: screenAwareSize(34.0, context),
              child: Row(
               // children: colorSelector(),
                children: <Widget>[
                  RawMaterialButton(
                    child:Radio(value: 1, groupValue: groupValue, onChanged: (int T){
                      setState(() {
                        groupValue= T ;
                      }); },activeColor: Colors.white,) ,
                    elevation: 6.0,
                    constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0
                    ),
                    shape: CircleBorder(),
                    fillColor: first_color ,
                    onPressed: (){},
                  ),
                  RawMaterialButton(
                    child:Radio(value: 2, groupValue: groupValue, onChanged: (int T){
                      setState(() {
                        groupValue= T ;
                      }); },activeColor: Colors.white,) ,
                    elevation: 6.0,
                    constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0
                    ),
                    shape: CircleBorder(),
                    fillColor: second_color ,
                    onPressed: (){},
                  ),
                  RawMaterialButton(
                    child:Radio(value: 3, groupValue: groupValue, onChanged: (int T){
                      setState(() {
                        groupValue= T ;
                      }); },activeColor: Colors.white,) ,
                    elevation: 6.0,
                    constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0
                    ),
                    shape: CircleBorder(),
                    fillColor: third_color ,
                    onPressed: (){},
                  ),
                  RawMaterialButton(
                    child:Radio(value: 4, groupValue: groupValue, onChanged: (int T){
                      setState(() {
                        groupValue= T ;
                      }); },activeColor: Colors.white,) ,
                    elevation: 6.0,
                    constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0
                    ),
                    shape: CircleBorder(),
                    fillColor: fourth_color ,
                    onPressed: (){},
                  ),
                  RawMaterialButton(
                    child:Radio(value: 5, groupValue: groupValue, onChanged: (int T){
                      setState(() {
                        groupValue= T ;
                      }); },activeColor: Colors.white,) ,
                    elevation: 6.0,
                    constraints: BoxConstraints.tightFor(
                        width: 56.0,
                        height: 56.0
                    ),
                    shape: CircleBorder(),
                    fillColor: fifth_color ,
                    onPressed: (){},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenAwareSize(8.0, context),
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color(0xFF01B2C4),
                        textColor: Colors.white,
                        child: Text('By now'),
                      )),
                  Expanded(
                      child: IconButton(
                          icon: (_addingToCart == false ) ? Icon(Icons.shopping_cart):CircularProgressIndicator(),
                          color: Color(0xFF01B2C4),
                          onPressed: () async {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            int userId = pref.getInt('user_id');
                            String api_token = pref.get('api_token');
                            if(userId == null || api_token ==null ){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() ));
                            }else{
                              setState(() {
                                _addingToCart = true ;
                              });
                              await _cartApi.addProductTocart(widget.product_id, _counter);
                              setState(() {
                                _addingToCart = false ;
                              });
                            }
                          }
                          )),
                  Expanded(
                      child: Post(product_description: widget.product_description,
                      product_name: widget.product_details_name,
                        id: widget.product_id,
                        product_price: widget.product_details_price,
                        product_old: widget.product_details_oldPrice,
                        product_picture: widget.product_details_picture,
                        productCategory: widget.productCategory,
                        productReviewCount: widget.productReviewCount,
                      ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenAwareSize(18.0, context),top:5.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only( right: 5 ),
                    child: Text(
                      "CUSTOMER FEEDBACK",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                        //   fontSize: screenAwareSize(10.0, context),
                        // fontFamily: "Montserrat-SemiBold"
                      ),
                    ),

                  ),
                  Expanded(child: Divider())
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenAwareSize(18.0, context),top:5.0),
              child: ListTile(
                title: Text("Product Raiting & Reviews "),
               trailing: IconButton(icon: Icon(Icons.arrow_forward_ios,size: 16.0,), onPressed: (){
                 Navigator.push(context, new MaterialPageRoute(builder: (context)=> new ProductRaiting(widget.product_id) ));
               }),
               subtitle: Row(
                 children: <Widget>[
                   Container(
                     decoration: BoxDecoration(
                    //   color: Colors.yellow,
                       border: Border.all(
                         color: Colors.amberAccent,
                         width: 2.0
                       ),
                     ),
                   ),
                   Text('  ('+widget.productReviewCount.toString()+' raiting)',
                       style: TextStyle(color: Colors.black)),
                 ],
               ),
               // subtitle: ,
              ),
            ),
            Divider(),
 /// ==================================================================================== Related Products row ==============*********************
            Padding(
              padding: EdgeInsets.all(10),
              child:Row(
                children: <Widget>[

                  Expanded(child: Row(
                    children: <Widget>[

                      Icon(FontAwesomeIcons.shoppingCart,
                        color: Colors.black87,
                        size: 30.0,
                      ),
                      Text('  Related Products',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  )
                  ),
                ],
              ),
            ),
            Horizintal_list(),
          ],
        ):_showLoading(),
      ),

    );
  }
  Future<void> moveToLastScreen() async
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new HomeScreen() ));
    return null;
  }


  __drawCard(dynamic item) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.product_id.toString()),
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

  _review(ProductReview productReview ){
    String st = productReview.stars.toString();
    String review = productReview.review ;
    return Container(
    //  height: 150.0,
      child: Card(
        child:ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: RatingBar.readOnly(
                      initialRating: double.parse(st),
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      size: 15.0,
                      filledColor: Colors.amber,
                      emptyColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0),
                child: AnimatedCrossFade(
                  firstChild: Text(
                    review,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0
                      //    fontSize: screenAwareSize(10.0, context),
                      //  fontFamily: "Montserrat-Medium"
                    ),
                  ),
                  secondChild: Text(
                    review,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                      // fontFamily: "Montserrat-Medium"
                    ),
                  ),
                  crossFadeState: isExpandedreview
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: kThemeAnimationDuration,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0),
                child: GestureDetector(
                    onTap: _expandReview,
                    child: Text(
                      isExpandedreview ? "less" : "more..",
                      style: TextStyle(
                          color: Color(0xFF01B2C4), fontWeight: FontWeight.w700),
                    )),
              ),
            ],
          ),
          subtitle: Padding(
            padding:  EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(18.0, context)),
            child: Text('By  '+ productReview.reviewer.last_name),
          ),
        ) ,
      ),
    );
  }

}


Widget _showLoading(){
  return Container(
    child:Center(
      child: CircularProgressIndicator(),
    ) ,
  );
}



Widget colorItem(
    Color color, bool isSelected, BuildContext context, VoidCallback _ontab) {
  return GestureDetector(
    onTap: _ontab,
    child: Padding(
      padding: EdgeInsets.only(left: screenAwareSize(10.0, context)),
      child: Container(
        width: screenAwareSize(30.0, context),
        height: screenAwareSize(30.0, context),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: isSelected
                ? [
              BoxShadow(
                  color: Colors.black.withOpacity(.8),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0))
            ]
                : []),
        child: ClipPath(
          clipper: MClipper(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: color,
          ),
        ),
      ),
    ),
  );
}

class MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget divider() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Container(
      width: 0.8,
      color: Colors.black,
    ),
  );
}

Widget sizeItem(String size, bool isSelected, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: Container(
      width: screenAwareSize(30.0, context),
      height: screenAwareSize(30.0, context),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xFF01B2C4) : Color(0xFF525663),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color:
                isSelected ? Colors.black.withOpacity(.5) : Colors.black12,
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: Center(
        child: Text(size,
            style:
            TextStyle(color: Colors.white, fontFamily: "Montserrat-Bold")),
      ),
    ),
  );
}



class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: new List.generate(this.itemCount,
              (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}