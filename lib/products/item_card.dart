import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Products.dart';
import 'constants.dart';

class ItemCard extends StatefulWidget {
  final Products product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                  gradient: new LinearGradient(
                      colors: [Colors.white, Colors.white10],
                      begin: Alignment.centerRight,
                      end: new Alignment(-1.0, -1.0)
                  ),
                border: Border.all(width: 3, color:Colors.white10)

              ),

              child: Hero(
                tag: "${widget.product.id}",
                child: Image.network(widget.product.image),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              // products is out demo list
              widget.product.title,
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontWeight: FontWeight.bold,letterSpacing: -1,color: Colors.black),
              ),
            ),
          ),

          Row(
            children: [
              Text(
                "\$${widget.product.price}",
                style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: -1,color: Colors.black),
              ),
              RatingBar.builder(
                itemSize: 15,
                initialRating: widget.product.rating.truncateToDouble(),
                itemCount: 5,
                itemBuilder: (context, index) {

                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 5,

                      );
                    case 1:
                      return Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 5,

                      );
                    case 2:
                      return Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 5,

                      );
                    case 3:
                      return Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 5,

                      );
                    case 4:
                      return Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 5,

                      );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
