import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/checkout/testAnimation.dart';
import 'package:flutter_app/details/comments.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/home_screen.dart';
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


    return FutureBuilder<bool>(
      future: AddOrder(store.baskets),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? HomeScreen()
            : Scaffold(

            backgroundColor: Colors.pinkAccent,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(backgroundColor: Colors.pink,),
                    Text("Loading..."),
                  ],
                )));
      },

    );
  }
}


Future<bool> AddOrder(List<Products> basket) async {
  bool result;
  print("inside addOder");
  for(int i = 0;i< basket.length ; i++ )
  {
    final Map<String, dynamic> OrderData = {
      'quantity': basket[i].size,
      'productid': basket[i].id,
      'price': basket[i].price*basket[i].size,
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