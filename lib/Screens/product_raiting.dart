import 'package:flutter/material.dart';
import 'package:pfe/api/reviews.dart';
import 'package:pfe/constants.dart';
import 'package:pfe/review/product_review.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:readmore/readmore.dart';

class ProductRaiting extends StatefulWidget {
  final productId;

  ProductRaiting(this.productId);

  @override
  _ProductRaitingState createState() => _ProductRaitingState();
}

class _ProductRaitingState extends State<ProductRaiting> {
  ReviewApi reviewApi = ReviewApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.appBarColor,
        title: Text('Product Raiting'),
      ),
      body: Container(
          child: FutureBuilder(
        future: reviewApi.fetchReviews(widget.productId, 10),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductReview>> snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              __error('no connection!!!');
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return _showLoading();
              break;
            case ConnectionState.done:
              if (snapShot.hasError) {
                return __error(snapShot.error.toString());
              } else {
                return ListView.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _review(snapShot.data[index]);
                  },
                );
              }
              break;
          }
          return Container();
        },
      )),
    );
  }

  __error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  Widget _showLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _review(ProductReview productReview) {
    var st = productReview.stars;
    String review = productReview.review;
    return Container(
      //  height: 150.0,
      child: Card(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: RatingBar.readOnly(
                      initialRating: st.toDouble(),
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
              ReadMoreText(
                review,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...Show more',
                trimExpandedText: ' show less',
              ),
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text('By  ' + productReview.reviewer.lastName),
          ),
        ),
      ),
    );
  }
}
