import 'package:flutter/material.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rounded_input_field.dart';
import '../textStyle.dart';
import '../text_field_container.dart';
import 'constants.dart';
import 'body.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/myStore.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return Scaffold(
      appBar: buildTest(),
      body: Body(),
    );
  }

  AppBar buildTest(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () {
          globalString = 'id1';
          globaldesc = false;
          globalasc = false;
          Navigator.of(context).pop();
        }
      ),

      centerTitle: true,
      title: Text(
        "TechIst",
        style: GoogleFonts.lato(
          textStyle: styleAppBar,
        ),
      ),

    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,


      actions: <Widget>[

        /*IconButton(
          icon: SvgPicture.asset(
            "assets/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),*/
        IconButton(
          icon: SvgPicture.asset(
            "assets/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: ()  {
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
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
