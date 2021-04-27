import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/search/search_history.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../details/details_screen.dart';
import 'constants.dart';
import '../models/Products.dart';
import 'item_card.dart';
import 'package:flutter_app/myStore.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {


  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {





  bool asc = false;
  bool desc = false;

  @override
  Widget build(BuildContext context) {

    var store = Provider.of<myStore>(context);
    List <Products> _products = [];

    if(globalString == "id2")
      {
        print(globalString);
        _products = store.computers;
        print(_products.length);
      }
    else{
      _products = store.products;
      print(_products);
      print("${_products} normal");
    }





    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[



                IconButton(
                  icon: Icon(Icons.trending_up),
                    // By default our  icon color is white
                    color: kTextColor,
                    onPressed: (){
                    setState(() {
                      _products.sort((b,a) => a.price.compareTo(b.price));
                    });
                    },
                  ),
                IconButton(
                  icon: Icon(Icons.trending_down),
                  // By default our  icon color is white
                  color: kTextColor,
                  onPressed: (){
                    setState(() {
                      _products.sort((a,b) => a.price.compareTo(b.price));
                    });



                    //store.products.sort(priceComparator);
                  },
                ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/search.svg",
                  // By default our  icon color is white
                  color: kTextColor,
                ),
                onPressed: ()  {
                  //showSearch(context: context, delegate: DataSearch());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Search();
                      },
                    ),
                  );
                },
              ),
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
                /*
                IconButton(
                  icon: Icons.account_circle_rounded,
                  color: kTextColor,
                  onPressed: (){},
                ),
                */
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/profile3.svg",
                    // By default our  icon color is white


                  ),
                  color: Colors.black,
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
              ],


            ),

            SizedBox(width: 20 / 2),
          ],
        ),
        Divider(
          thickness: 8,
          height: 8,
          color: kPrimaryColor,
        ),


        SizedBox(height: 16,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                itemCount: _products.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return ItemCard(

                    product: _products[index],
                    press: () {
                      store.setActiveProduct(_products[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen();
                            },
                          ),
                        );
                    }
                  );

                }
            ),
                    )
        ),
        SizedBox(height: 16,),


      ],

    );

  }
}
