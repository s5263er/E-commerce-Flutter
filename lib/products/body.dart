import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../details/details_screen.dart';
import 'constants.dart';
import '../models/Products.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  List<ItemCard> cartList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Row(
          children: [
            Container(
              width: 350,
              height: 40,
              child: TextField(
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),

                ),
                keyboardType: TextInputType.visiblePassword,
                textAlignVertical: TextAlignVertical.bottom,
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
            IconButton(
              icon: SvgPicture.asset(
                "assets/cart.svg",
                // By default our  icon color is white
                color: kTextColor,
              ),
              onPressed: () {},
            ),
            SizedBox(width: kDefaultPaddin / 2),
          ],
        ),


        SizedBox(height: 16,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) {
                          return DetailsScreen(product: products[index],);
                          },
                          ),
                          ),
                          )
            ),
                    )
        ),
        SizedBox(height: 16,),


      ],
    );
  }
}
