import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/models/Products.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../myStore.dart';
import '../textStyle.dart';
import 'cart_counter.dart';
import 'comments.dart';


class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    Key key,
    @required this.product,

  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        Text(


          'Product comments',
        textAlign: TextAlign.end,
        style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: -1,
          fontStyle: FontStyle.italic,
        ),

        ),
        ),
        Container(

          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
          ),
          child: new IconTheme(
                    data: new IconThemeData(color: Colors.white),
                    child: IconButton(icon: Icon(Icons.comment_rounded,size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyComments(productid: product.id);
                              },
                            ),
                          );
                        }
                    )


                    ))],
    );
  }
}


