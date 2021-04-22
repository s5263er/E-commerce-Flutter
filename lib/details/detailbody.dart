import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/details/add_to_cart.dart';
import 'package:flutter_app/details/color_and_size.dart';
import 'package:flutter_app/details/product_title_with_image.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';
import 'cart_counter.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';

class DetailBody extends StatelessWidget {

  const DetailBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(top:size.height*0.12, left: kDefaultPaddin, right: kDefaultPaddin),
                  height: 500,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: store.activeProduct),
                      SizedBox(height: kDefaultPaddin/2),
                      Description(product: store.activeProduct),
                      SizedBox(height: kDefaultPaddin/2),
                      CounterWithFavBtn(),
                      SizedBox(height: kDefaultPaddin/2),
                      AddToCart(),
                      
                    ],
                  )
                ),
                ProductTitleWithImage(product: store.activeProduct)
              ],
            )
          )
        ],
      ),
    );
  }
}









