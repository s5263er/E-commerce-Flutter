import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/details/profile_screen.dart';
import 'package:flutter_app/search/search_history.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:flutter_app/welcome.dart';
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

List <Products> Sorter(List <Products> products)
{
  products.sort((b,a) => a.price.compareTo(b.price));
}

class _BodyState extends State<Body> {
  bool kalkan = false;






  bool asc = false;
  bool desc = false;
  double _lowerValue = globalmin;
  double _upperValue = globalmax;



  @override
  Widget build(BuildContext context) {

    var store = Provider.of<myStore>(context);
    List <Products> _products = [];

    if(globalString == "id2")
      {
        _products = store.computers;


      }
    else if(globalString == "id3"){
      _products = store.tvs;

    }
    else if(globalString == "id4"){
      _products = store.cameras;

    }
    else if(globalString == "id5"){
      _products = store.phones;

    }
    else{

      _products = store.products;


    }

    if(globalasc == true)
      {
        print("asc");
        _products.sort((b,a) => a.price.compareTo(b.price));
        globalasc = false;
      }
    if(globaldesc == true)
      {
        _products.sort((a, b) => a.price.compareTo(b.price));
        print("desc");
        globaldesc = false;
      }
    //List <Products> _products2 = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();

    _products = _products.where((element) => element.price >= _lowerValue && element.price <= _upperValue).toList();


    //print('lalalala ${globalmax}');








    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Expanded(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[



/*
              IconButton(
                icon: Icon(Icons.trending_up),
                  // By default our  icon color is white
                  color: kTextColor,
                  onPressed: (){
                  setState(() {
                    //
                    //store.getSortedList(_products);
                    kalkan = true;
                    _products.sort((b,a) => a.price.compareTo(b.price));
                    _products = _products.where((element) => element.price >= _lowerValue && element.price <= _upperValue).toList();
                    for(var i in _products)
                    {
                      print("${i.title} bu iki");
                    }




                    //_products.sort((b,a) => a.price.compareTo(b.price));
                    //_products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();

                  });
                  },
                ),
              IconButton(
                icon: Icon(Icons.trending_down),
                // By default our  icon color is white
                color: kTextColor,
                onPressed: (){
                  setState(() {
                    kalkan = true;


                      _products.sort((a, b) => a.price.compareTo(b.price));
                    _products = _products.where((element) => element.price >= _lowerValue && element.price <= _upperValue).toList();
                      //_products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
                      //print('${_products2[0].price}');


                  });



                  //store.products.sort(priceComparator);
                },
              ),*/
            IconButton(
              icon: Icon(Icons.search_sharp),
              onPressed: ()  {
                globalmin = 0;
                globalmax = 5000;
                globalasc = false;
                globaldesc = false;
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

              /*
              IconButton(
                icon: Icons.account_circle_rounded,
                color: kTextColor,
                onPressed: (){},
              ),
              */

              IconButton(
                icon: Icon(Icons.account_circle),
                color: Colors.black,
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if(store.login == true){
                          return ProfileScreen(username: store.username);
                        }
                        else{
                        return WelcomeScreen();}
                      },
                    ),
                  );
                },
              ),

              IconButton(
                icon: Icon(Icons.shopping_cart_sharp),
                onPressed: ()  {
                  globalmin = 0;
                  globalmax = 5000;
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


