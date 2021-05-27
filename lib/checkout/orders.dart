import 'package:flutter/material.dart';
import 'package:flutter_app/SplashScreens/PaymentSuccessSplash.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/checkout/testAnimation.dart';
import 'package:flutter_app/details/comments.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app/products/constants.dart';
import '../myStore.dart';

class Order extends StatelessWidget {

  Order({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    for(var i in store.baskets)
    {
      print("girdi aq");
      int id = i.id;
      for(var j in store.products)
      {
        if(j.id == i.id)
        {
          j.quantity = j.quantity - i.size;
          print(j.title);
          print(j.size);
          print(j.quantity);
        }
      }
    }


    return FutureBuilder<bool>(
      future: AddOrder(store.baskets,store.adress),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);

        if(snapshot.hasData){
          store.delProducts();
        }

        return snapshot.hasData
            ? PaymentSuccess()
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


Future<bool> AddOrder(List<Products> basket,String adr) async {
  bool result;
  print("inside addOder");
  for(int i = 0;i< basket.length ; i++ )
  {
    final Map<String, dynamic> OrderData = {
      'quantity': basket[i].size,
      'productid': basket[i].id,
      'price': basket[i].discountrate == 0?basket[i].price*basket[i].size: basket[i].discprice*basket[i].size,
      'address': adr,
    };

    print("item ${basket[i].title}");
    http.Response response = await http.post(
        Uri.parse("http://10.0.2.2:5000/Order/add"),
        body: json.encode(OrderData),
        headers: {'Content-Type': 'application/json; charset=utf-8', 'Accept':'application/json','Authorization': 'Bearer $globalToken'}
    );

    if (response.statusCode == 200) {
      print("yes amk");
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = responseData['success'];

    }
    else if (response.statusCode == 400){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = responseData['success'];

    }
    else{
      result = false;
    }
  }

  return result;
}