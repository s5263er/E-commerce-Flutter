import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/PreviousOrders/previousOrders.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';

class Invoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Invoice"),
      ),
      body: Column(
        children: [

      Expanded(
      child: ListView.builder(
      itemCount: store.baskets.length,
        itemBuilder: (BuildContext context,int i)
        {

          return Column(
            children: [

              Row(
                children: <Widget>[
                  Expanded(flex: 2,
                    child: Image.network(store.baskets[i].image),


                  ),
                  store.baskets[i].discountrate == 0?Expanded(flex: 2,child: Text(store.baskets[i].title + " Price: " + store.baskets[i].price.toString() + "\$")):
                  Expanded(flex: 2,child: Text(store.baskets[i].title + " Price w/Discount: " + store.baskets[i].discprice.toString() + "\$",)),
                  Expanded(flex: 2,child: Container(
                    decoration: BoxDecoration(
                    ),
                  )
                  ),




                ],
              ),
              Divider(
                height: 15,
                color: kPrimaryColor,
                thickness: 5,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                          text: "Total \n",
                          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                          children: [
                            TextSpan(
                                text: "${store.getTotalCost()} \$",
                                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPrimaryColor))
                            )
                          ]
                      ),
                    ),
                    AnimatedButton(
                      shadowDegree: ShadowDegree.dark,
                      color: kPrimaryColor,
                      onPressed: () {
                        store.delProducts();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyApps();
                            },
                          ),
                        );
                      },
                      child: Text(
                          "Main page",
                          style: GoogleFonts.lato(textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      ),
                    ),
                    AnimatedButton(
                      shadowDegree: ShadowDegree.dark,
                      color: kPrimaryColor,
                      onPressed: () {
                        store.delProducts();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {

                              return OrderScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                          "Show previous purchases",
                          style: GoogleFonts.lato(textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      ),
                    )

                  ],
                ),),

            ],

          );

        },

    ))]
      ));
  }
}

/**/



