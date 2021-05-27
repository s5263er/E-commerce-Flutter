import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

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

              product.discountrate == 0?RichText(

                text: TextSpan(
                  children:  [
                    TextSpan(text: "Price\n"),
                    TextSpan(text: "\$${product.price}", style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              ):
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "%${product.discountrate} Discount\n",style: TextStyle(color: Colors.lightGreen)),
                              TextSpan(text: "\$${product.price}", style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.redAccent,decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold)),
                            ]
                        )),
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "\$${product.discprice}", style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.lightGreen,decoration: TextDecoration.underline, fontWeight: FontWeight.bold))

                            ]
                        )),
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