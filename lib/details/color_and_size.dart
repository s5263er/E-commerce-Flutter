import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/models/Products.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';
import '../textStyle.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Products product;
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  RatingBar.builder(
                    initialRating: product.rating.truncateToDouble(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                    },
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.end,
              text: TextSpan(
                  style: TextStyle(color: Colors.black12),
                  children: [
                    TextSpan(

                      text: "${product.quantity} item left in stock",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: -1,
                          fontStyle: FontStyle.italic,
                        )
                      ),
                    )
                  ]
              )),
        )
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;


  const ColorDot({
    Key key,
    this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: kDefaultPaddin/4, right: kDefaultPaddin /2),
        padding: EdgeInsets.all(2.5),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
            )
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        )
    );
  }
}