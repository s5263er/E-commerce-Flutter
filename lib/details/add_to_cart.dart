import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class AddToCart extends StatelessWidget {
  const AddToCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget> [
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: kPrimaryColor)
            ),
            child: IconButton(
              icon: SvgPicture.asset("assets/icons/add_to_cart.svg",color: kPrimaryColor,),
              onPressed: () {

                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Item added successfully')));
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                color: kPrimaryColor,
                onPressed: () {
                  //showAlertDialog('title', 'msg');
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Item added successfully')));
                },
                child: Text(
                    "BUY NOW",
                    style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

