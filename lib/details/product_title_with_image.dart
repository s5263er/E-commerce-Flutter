import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/Products.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
              product.title,
              style: Theme.of(context).textTheme.headline4.copyWith(
                  color:Colors.white, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: kDefaultPaddin,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              RichText(
                text: TextSpan(
                  children:  [
                    TextSpan(text: "Price\n"),
                    TextSpan(text: "\$${product.price}", style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Container(
                alignment: Alignment.bottomRight,
                width: 200,
                height: 200,
                child: Image.network(product.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}