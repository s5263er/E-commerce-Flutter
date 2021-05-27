import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Profile/changeAddress.dart';
import 'package:flutter_app/checkout/checkoutScreen.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<String> getAddr() async {
  String url = 'http://10.0.2.2:5000/Customer/GetById';


  final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',});
  print('buraya da girdi');
  print(response.statusCode);
  if (response.statusCode == 200) {

    Map<String, dynamic> map = await json.decode(response.body);
    print(map["data"]);
    //print(map["data"][4]);
   // print(map["data"].map((obj) => User.fromJson(obj)));

    dynamic data;
    data = map["data"];


    //List<dynamic> data = map["data"];
    String cemil = map["data"]["address"];
    print(cemil);
    print("buraya girdik");
    //print(data.map((obj) => User.fromJson(obj)).address);
    print("buraya girdik2");



    //print(denemelisti.first.comment);
    return cemil;

  }
  //print(response.statusCode);
  else{
    print("adresi alamiyok");
  }
}


class FutureChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String data;
    return FutureBuilder<String>(

      future: getAddr(),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          print("${snapshot.data} adresin bu diyor");
          data = snapshot.data;
        };


        return snapshot.hasData
            ? changeAddr(erdem: data)
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

class FutureForCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String data;
    return FutureBuilder<String>(

      future: getAddr(),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          print("${snapshot.data} adresin bu diyor");
          data = snapshot.data;
        };


        return snapshot.hasData
            ? checkoutScreen(erdem: data)
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
