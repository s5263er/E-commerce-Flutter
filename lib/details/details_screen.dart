import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/details/detailbody.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {


  const DetailsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: DetailBody(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () =>Navigator.pop(context),
      ),
      actions: <Widget> [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CartScreen();
                },
              ),
            );
          },
        ),
        SizedBox(width: kDefaultPaddin /2),
      ]



    );
  }
}
