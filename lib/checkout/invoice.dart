import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/PreviousOrders/previousOrders.dart';
import 'package:flutter_app/invoice_pdf/pdf_page.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';

class Invoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    int one_total;
    print("${store.baskets.length}, bu kadar item var baskette");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Invoice"),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

                AnimatedButton(
                  shadowDegree: ShadowDegree.dark,
                  color: kPrimaryColor,
                  onPressed: () {
                    //store.delProducts();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PdfPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                      "Generate invoice",
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
        ));
  }
}





/**/



