import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 2, color: kPrimaryColor)

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
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${widget.product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
