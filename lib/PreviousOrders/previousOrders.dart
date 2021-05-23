import "package:flutter/material.dart";
import 'package:flutter_app/checkout/checkoutScreen.dart';

import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/models/Order.dart';
import 'package:flutter_app/signup_screen.dart';
import 'package:flutter_app/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";
import 'package:flutter_app/shopping_cart/cart_body.dart';


import '../models/Products.dart';
import '../myStore.dart';

showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Sign Up"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignUpScreen();
          },
        ),
      );
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Login"),
    onPressed:  () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("You are not logged in"),
    content: Text("You need to be logged in to checkout your cart. Please log in or sign up in order to proceed"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class  OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Previous Orders"),
        ),
        body: Column(
          children: [

            Expanded(
              child: ListView.builder(
                itemCount: store.order.length,
                itemBuilder: (BuildContext context,int i)
                {

                  return Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(flex: 2,
                            child: Image.network(store.getProduct(store.order[i].productId).image),


                          ),
                          Expanded(flex: 2,child: Text(store.getProduct(store.order[i].productId).title +"\n" + "Quantity: " + store.order[i].quantity.toString() +"\n" +" Price: " + store.order[i].price.toString() + "\$")),
                          Expanded(flex: 2,child: Container(
                            decoration: BoxDecoration(
                            ),
                            child: Column(

                              children: <Widget>[
                                Text(store.order[i].createDate.substring(0,10)),
                                SizedBox(height: 12,),
                                Status(store.order[i]),
                              ],

                            ),
                          )
                          ),
                          Expanded(flex:2,child: buttons(store.order[i]),),

                        ],
                      ),
                      Divider(
                        height: 15,
                        color: kPrimaryColor,
                        thickness: 5,
                        indent: 10,
                        endIndent: 10,
                      )

                    ],

                  );

                },

              ),
            ),

          ],
        )

    );
  }
}

Widget buttons (Order ord){
  if(ord.status == 0)
  {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kPrimaryColor,
      onPressed: () {},
      child: Text(
          "CANCEL",
          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
      ),
    );
  }
  if(ord.status == 2)
  {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kPrimaryColor,
      onPressed: () {},
      child: Text(
          "REFUND",
          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
      ),
    );
  }
  else
    return Text(" ");

}

Widget Status (Order ord){

  if(ord.status == 0)
  {
    return Text("Processing",
    style: TextStyle(color: Colors.red),
    );

  }
  else if(ord.status == 1)
  {
    return Text("In-Transit",
      style: TextStyle(color: Colors.blue),
    );

  }
  else if(ord.status == 2)
  {
    return Text("Delivered",
      style: TextStyle(color: Colors.green),
    );

  }
  else
    return Text("SLM");

}