import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_app/checkout/checkoutScreen.dart';

import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/models/Order.dart';
import 'package:flutter_app/signup_screen.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";
import 'package:flutter_app/shopping_cart/cart_body.dart';
import 'package:http/http.dart' as http;

import '../models/Products.dart';
import '../myStore.dart';
import '../products/constants.dart';
import 'getOrders.dart';
import 'getOrders.dart';

showAlertDialogCancel(BuildContext context, int id) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Cancel",
      style: TextStyle(color: Colors.red),
    ),
    onPressed:  () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return cancelOrder(id: id,status: 3,);
          },
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Do you want to cancel the order?"),
    content: Text("This process can not be retrieved. Please press cancel if you want to cancel the order"),
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

showAlertDialogRefund(BuildContext context, int id) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Send Refund Request",
      style: TextStyle(color: Colors.red),
    ),
    onPressed:  () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return cancelOrder(id: id,status: 4,);
          },
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Do you want to refund the order?"),
    content: Text("Please press yes if you want to send a refund request"),
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
                          Expanded(flex:2,child: buttons(store.order[i],context)),

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

Widget buttons (Order ord, BuildContext context){
  if(ord.status == 0)
  {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: kPrimaryColor,
      onPressed: () {
        showAlertDialogCancel(context,ord.id);
      },
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
      onPressed: () {
        showAlertDialogRefund(context, ord.id);
      },
      child: Text(
          "REFUND",
          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
      ),
    );
  }
  else if(ord.status == 3)
  {
    return Text("Canceled",
      style: TextStyle(color: Colors.red),
    );

  }
  else if(ord.status == 4)
  {
    return Text("Refund Request Sent",
      style: TextStyle(color: Colors.red),
    );

  }
  else if(ord.status == 5)
  {
    return Text("Refund Process Completed",
      style: TextStyle(color: Colors.red),
    );

  }
  else
    return Text(" ");

}

Widget Status (Order ord){

  if(ord.status == 0)
  {
    return Text("Processing",
      style: TextStyle(color: Colors.yellow.shade900),
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
  /*else if(ord.status == 3)
  {
    return Text("Canceled",
      style: TextStyle(color: Colors.red),
    );

  }
  else if(ord.status == 4)
  {
    return Text("Refund Request Sent",
      style: TextStyle(color: Colors.red),
    );

  }
  else if(ord.status == 5)
  {
    return Text("Refund Process Completed",
      style: TextStyle(color: Colors.red),
    );

  }*/
  else
    return Text(" ");

}

Future<bool> cancel(String globalToken, int id, int status) async {
  bool result = false;

  final Map<String, dynamic> cancelData = {
    'id': id,
    'status': status
  };

  http.Response response = await http.put(
      Uri.parse("http://10.0.2.2:5000/Order/ChangeStatus"),
      body: json.encode(cancelData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    List<dynamic> data = responseData["data"];
    result = responseData["success"];


  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData["success"];
  }
  else
    print("sıkıntı");
  return  result;
}

class cancelOrder extends StatelessWidget {
  int id,status;

  cancelOrder({Key key, this.id,this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return FutureBuilder<bool>(
      future: cancel(globalToken, id, status),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? myOrders()
            : Scaffold(

            backgroundColor: kPrimaryColor,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //CircularProgressIndicator(backgroundColor: Colors.pink,),
                    SpinKitFadingFour(
                      size: 100,
                      color: Colors.white12,
                    ),
                    Text(
                      "Loading...",
                      style: GoogleFonts.arimaMadurai(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),



                  ],
                )));
      },

    );
  }
}