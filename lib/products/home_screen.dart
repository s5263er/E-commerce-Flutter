import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rounded_input_field.dart';
import '../textStyle.dart';
import '../text_field_container.dart';
import 'constants.dart';
import 'body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTest(),
      body: Body(),
    );
  }


  AppBar buildTest(){
    return AppBar(
      centerTitle: true,
      title: Text(
        "AppBar",
        style: GoogleFonts.lato(
          textStyle: styleAppBar,
        ),
      ),

    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      actions: <Widget>[
        Container(
          width: 350,
          height: 20,
          child: TextField(
            
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    "assets/search.svg",
                    // By default our  icon color is white
                    color: kTextColor,
                  ),
                  onPressed: () {},
                ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
               hintText: 'Search...',
          ),
          ),
        ),
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
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
