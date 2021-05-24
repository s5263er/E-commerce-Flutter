import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/PreviousOrders/previousOrders.dart';

import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/models/Order.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class myOrders extends StatelessWidget {

  myOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return FutureBuilder<List<Order>>(
      future: getOrder(globalToken),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          store.setOrders(snapshot.data);
        }

        return snapshot.hasData
            ? OrderScreen()
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



Future<List<Order>> getOrder(String globalToken) async {
  List<Order> result = [];
  print("response öncesi");
  http.Response response = await http.get(
      Uri.parse("http://10.0.2.2:5000/Order/getbyid"),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );
  print("getOrder");
  print(response.statusCode);

  if (response.statusCode == 200) {
    print("yes amk4444");
    final Map<String, dynamic> responseData = json.decode(response.body);
    List<dynamic> data = responseData["data"];

    return data.map((obj) => Order.fromJson(obj)).toList();

  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("get order olmadi mystoredayim");
  }
  return  result;
}
