import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import "package:flutter/material.dart";
import 'package:flutter_app/Profile/adrfuture.dart';
import 'package:flutter_app/checkout/checkoutScreen.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";
import 'package:flutter_app/shopping_cart/cart_body.dart';


import '../models/Products.dart';
import '../myStore.dart';
import 'package:http/http.dart' as http;



//farkli

Future<List<Products>> getCart(String globalToken) async {
  List<Products> result = [];

  http.Response response = await http.get(
      Uri.parse("http://10.0.2.2:5000/ShoppingCart/getcart"),
      //body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    //print("yes amk4444");
    final Map<String, dynamic> responseData = json.decode(response.body);
    //print("yes amk3535794");
    //print(responseData);
    //print("deneme1");
    List<dynamic> data = responseData["data"]["items"];
   //print("deneme2");
    //print(data);

    return data.map((obj) => Products.fromJson(obj)).toList();



  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("get cart olmadi mystoredayim/cartscreen");
  }
  return  result;
}

Future<bool> getBoolCart(String globalToken) async {
  bool result = false;
  http.Response response = await http.get(
      Uri.parse("http://10.0.2.2:5000/ShoppingCart/getcart"),
      //body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    print("yes amk44445");
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData["success"];

    print("$result asdhlaskdhasd;");

    return result;



  } else if (response.statusCode == 400){
    print("get cart olmadi mystoredayim/cartscreen");
  }
  return  result;
}

Widget _buildButton({VoidCallback onTap, String text, Color color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: MaterialButton(
      color: color,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}



class  CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final errorAlert = _buildButton(
      onTap: () {

      },
      text: 'Error',
      color: Colors.red,
    );
    var store = Provider.of<myStore>(context);
    return store.login ? FutureBuilder<bool>(
      future: getBoolCart(globalToken),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);
        if (snapshot.hasData) {
          print("çalışıyor gibi");
        }

        if (snapshot.data == true) {
          return FutureBuilder<List<Products>>(
            future: getCart(globalToken),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              if (snapshot.hasData) {
                print("${store.baskets2} hopppala bostu hani");
                store.setProducts(snapshot.data);
                print("cartscreen itemleralindi");
              };


              return snapshot.hasData
                  ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Your Cart"),
                    actions: <Widget> [
                      pressed != 0 ? const SizedBox.shrink() :
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: (){
                      setState((){
                        if(store.baskets2.isEmpty){
                          print("basket2 empty");
                          pressed++;
                          //SnackBar(content: Text('Item added successfully'));
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            title: 'Oops...',
                            text: 'You did not add any items to your basket before you logged in',
                            confirmBtnColor: kPrimaryColor,
                            backgroundColor: kPrimaryColor,
                            confirmBtnText: "OK",
                            loopAnimation: false,
                          );
                        }
                        else{
                          setState(() {
                            pressed++;

                            for(Products i in store.baskets2){
                              store.addOneItemBasket(i, i.size);
                            }
                            store.delProducts2();
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              title: 'Success',
                              text: 'Transaction completed successfully!',
                              confirmBtnColor: kPrimaryColor,
                              backgroundColor: kPrimaryColor,
                              confirmBtnText: "OK",
                              loopAnimation: false,
                            );
                          });
                        }

                      });
                    },
                    child: Text("Bring added items"),
                    shape: RoundedRectangleBorder(side: BorderSide(color: kPrimaryColor),),
                  )
                    ],

                  ),
                  body: Column(
                    children: [

                      Expanded(
                        child: ListView.builder(
                          itemCount: store.baskets.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Column(
                              children: [

                                Row(
                                  children: <Widget>[
                                    Expanded(flex: 2,
                                      child: Image.network(store.baskets[i].image),


                                    ),
                                    Expanded(flex: 2,
                                        child: Text(
                                            store.baskets[i].title + " Price: " +
                                                store.baskets[i].price.toString() +
                                                "\$")),
                                    Expanded(flex: 2, child: Container(
                                      decoration: BoxDecoration(
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.arrow_upward,
                                              color: Colors.green,),
                                              onPressed: () {
                                                setState(() {
                                                  //store.baskets[i].size = store.baskets[i].size -1;
                                                  print(store.baskets[i].id);
                                                  int id = store.baskets[i].id;
                                                  Products producter;
                                                  for(var i in store.products)
                                                    {
                                                      if(i.id == id)
                                                        {
                                                          producter = i;
                                                        }
                                                    }
                                                 // producter = store.products.where((element) => element.id == id).
                                                 // _products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
                                                  if(producter.quantity > store.baskets[i].size)
                                                    {
                                                  store.addOneItemBasket(
                                                      store.baskets[i],1);}
                                                  else{
                                                    print(producter.quantity);
                                                    print("ustu quanttity");
                                                    CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.warning,
                                                      title: 'Oops...',
                                                      text: '${producter.quantity} items left in stock',
                                                      confirmBtnColor: kPrimaryColor,
                                                      backgroundColor: kPrimaryColor,
                                                      confirmBtnText: "OK",
                                                      loopAnimation: false,
                                                    );

                                                  }
                                                });
                                              }
                                          ),
                                          Text(store.baskets[i].size.toString()),
                                          IconButton(
                                            icon: Icon(Icons.arrow_downward,
                                              color: Colors.red,),
                                            onPressed: () {
                                              setState(() {
                                                //store.baskets[i].size = store.baskets[i].size -1;
                                                store.removeBasket(
                                                    store.baskets[i]);
                                              });
                                            }

                                                //store.removeBasket(
                                                   // store.baskets[i]),
                                          ),
                                        ],
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
                                )

                              ],

                            );
                          },

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "Total \n",
                                style: GoogleFonts.lato(textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)),
                                children: [
                                  TextSpan(
                                      text: "${store.getTotalCost()} \$",
                                      style: GoogleFonts.lato(textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor))
                                  )
                                ]
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FutureForCheckout();
                                  },
                                ),
                              );
                            },
                            child: Text(
                                "CHECK OUT",
                                style: GoogleFonts.lato(textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                            ),
                          )
                        ],

                      ),


                    ],
                  )

              )
                  : Scaffold(

                  backgroundColor: Colors.black,
                  body:
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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

        else{
          return Scaffold(

              backgroundColor: Colors.black,
              body:
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
        }
        }
        ,

    ): Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Your Cart"),
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
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_upward,color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      Products producter;
                                      int id = store.baskets[i].id;
                                      for(var i in store.products)
                                      {
                                        if(i.id == id)
                                        {
                                          producter = i;
                                        }
                                      }
                                      // producter = store.products.where((element) => element.id == id).
                                      // _products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
                                      if(producter.quantity > store.baskets[i].size)
                                      {
                                        store.addOneItemBasket(
                                            store.baskets[i],1);}
                                      else{
                                        print(producter.quantity);
                                        print("ustu quanttity");
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          title: 'Oops...',
                                          text: '${producter.quantity} items left in stock',
                                          confirmBtnColor: kPrimaryColor,
                                          backgroundColor: kPrimaryColor,
                                          confirmBtnText: "OK",
                                          loopAnimation: false,
                                        );

                                      }
                                    });
                                  },
                                ),
                                Text(store.baskets[i].size.toString()),
                                IconButton(
                                  icon: Icon(Icons.arrow_downward,color: Colors.red,),
                                  onPressed: () {
                                    setState(() {
                                      store.removeBasket(store.baskets[i]);
                                    });
                                  },
                                ),
                              ],
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
                      )

                    ],

                  );

                },

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  color: kPrimaryColor,
                  onPressed: () {

                  },
                  child: Text(
                      "CHECK OUT",
                      style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
                  ),
                )
              ],

            ),


          ],
        )

    );


  }
}
/*
FlatButton(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
color: kPrimaryColor,
onPressed: () {},
child: Text(
"BUY NOW",
style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
),
),
*/