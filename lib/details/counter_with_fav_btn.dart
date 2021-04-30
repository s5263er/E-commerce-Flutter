import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../textStyle.dart';
import 'cart_counter.dart';


class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    Key key,
  }) : super(key: key);

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
                    child: new Icon(Icons.comment_rounded,size: 30,)

                    ))],
    );
  }
}