import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SplashScreens/ChangePassError.dart';
import 'package:flutter_app/SplashScreens/ChangePassSuccess.dart';
import 'package:flutter_app/details/profilebody.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Products.dart';

List<Products> data = [];

/*Future<List<Products>> getCart(String globalToken) async {
  List<Products> result = [];

  http.Response response = await http.get(
      Uri.parse("http://127.0.0.1:5000/ShoppingCart/getcart"),
      //body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    print("yes amk4444");
    final Map<String, dynamic> responseData = json.decode(response.body);
    List<dynamic> data = responseData["data"]["items"];

    return data.map((obj) => Products.fromJson(obj)).toList();



  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("get cart olmadi mystoredayim");
  }
  return  result;
}*/

Future<int> getCartId(String globalToken) async {
  http.Response response = await http.get(
      Uri.parse("http://127.0.0.1:5000/ShoppingCart/getcart"),
      //body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );
  int data;

  print(response.statusCode);

  if (response.statusCode == 200) {
    print("getCartId okey");
    final Map<String, dynamic> responseData = json.decode(response.body);
    data = responseData["data"]["id"];

    return data;



  } else if (response.statusCode == 400){
    //final Map<String, dynamic> responseData = json.decode(response.body);
    print("get cart id olmadi mystoredayim");
  }
  return data;
}


class LogApp extends StatelessWidget {
  String username;
  String password;

  LogApp({Key key,this.username,this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return FutureBuilder<bool>(
      future: login(username,password),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);
        if(snapshot.hasData){
          store.login = snapshot.data;
          /*if(snapshot.data == true){
            return FutureBuilder<int>(
              future: getCartId(globalToken),
              builder: (context, snapshot) {

                if (snapshot.hasError) print(snapshot.error);
                if(snapshot.hasData){
                  store.setShoppingCartId(snapshot.data);
                  print(snapshot.data);
                  print("bu userin shopping cartidsi yukaridadir");
                };
              },

            );
          }*/
        }

        if(!snapshot.hasData)
        {
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
        /*if(snapshot.data == true)
          {
            if(store.baskets.isNotEmpty){
              for(Products i in store.baskets)
                {
                  store.addOneItemBasket(i, i.size);
                }
            }
          }*/



        else {
          if(snapshot.data == true)
          {
            store.setProducts2(store.baskets);
          }
          return (snapshot.data == true)
              ? MyApps()
              : Scaffold(

              backgroundColor: Colors.black,
              body:
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Username or Password is wrong please try again",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50,),
                      ElevatedButton(

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty
                                  .resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.black;
                                  return Colors
                                      .purple; // Use the component's default.
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                      side: BorderSide(color: Colors.purple)
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Login Page", style: TextStyle(fontSize: 25),)
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty
                                  .resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.black;
                                  return Colors
                                      .purple; // Use the component's default.
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                      side: BorderSide(color: Colors.purple)
                                  )
                              )
                          ),
                          onPressed: () {
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
                            "Home Page", style: TextStyle(fontSize: 25),)
                      )
                    ],
                  )

              ));
        }


      },

    );
  }
}
Future<bool> ChangePass(String username, String password,String newpassword) async {
  bool result;

  final Map<String, dynamic> registerData = {
    'username': username,
    'password': password,
    'newpassword': newpassword
  };



  http.Response response = await http.put(
      Uri.parse("http://10.0.2.2:5000/Authentication/changepassword"),
      body: json.encode(registerData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken'}
  );



  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];
  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];


  }
  print("$result change password http response");
  return result;
}
// ignore: must_be_immutable
class ChangePass2 extends StatefulWidget {

  String username,password,newpassword;


  ChangePass2({Key key,this.username,this.password,this.newpassword}) : super(key: key);

  @override
  _ChangePass2State createState() => _ChangePass2State();
}

class _ChangePass2State extends State<ChangePass2> {
  @override
  Widget build(BuildContext context) {
    print("girdiuser");
    return FutureBuilder<bool>(
      future: ChangePass(widget.username,widget.password,widget.newpassword),
      builder: (context, snapshot) {
        print("girdiuser2");

        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);

        if(!snapshot.hasData)
        {
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
        else {
          return (snapshot.data == true)
              ? ChangePassSplash()
              : ChangePassSplashErr();
        }


      },

    );
  }
}

class RegApp extends StatelessWidget {
  String name,surname,username,email,phoneNumber,password;

  RegApp({Key key,this.username,this.password,this.email,this.phoneNumber,this.surname,this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Register(username,password,name,surname,phoneNumber,email),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);

        if(!snapshot.hasData)
        {
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

        return (snapshot.data == true)
            ? Scaffold(

            backgroundColor: Colors.black,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Successfully Registered!",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.black;
                                return Colors.purple; // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.purple)
                                )
                            )
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyApps();
                            },
                          ),
                        );},
                        child: Text("Home Page Without Login",style: TextStyle(fontSize: 25),)
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.black;
                                return Colors.purple; // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.purple)
                                )
                            )
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );},
                        child: Text("Login Page To Login",style: TextStyle(fontSize: 25),)
                    ),
                  ],
                )

            ))
            : Scaffold(

            backgroundColor: Colors.pinkAccent.shade100,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("User Already Exists!",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.black;
                                return Colors.purple; // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.purple)
                                )
                            )
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );},
                        child: Text("Login Page To Login",style: TextStyle(fontSize: 25),)
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.black;
                                return Colors.purple; // Use the component's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.purple)
                                )
                            )
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyApps();
                            },
                          ),
                        );},
                        child: Text("Home Page Without Login",style: TextStyle(fontSize: 25),)
                    ),
                  ],
                )

            ));


      },

    );
  }
}

bool followRedirects = true;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class User {
  String name, surname, username,phoneNumber, mailAddress;
  int id;
  List <Products> basket = [];

  User({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.mailAddress,
    this.phoneNumber,
    this.basket,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      username: json['username'] as String,
      mailAddress: json['mailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,

    );
  }
}

Future<bool> login(String username, String password) async {
  bool result;

  final Map<String, dynamic> loginData = {
    'username': username,
    'password': password
  };



  http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:5000/Authentication/login"),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8'}
  );



  if (response.statusCode == 200) {
    print("yes amk");
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = await responseData['success'];
    globalToken = await responseData['data'];
    print(globalToken);
    print(result.toString());
    //var userData = responseData['data'];

    //User authUser = User.fromJson(userData);


  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = await responseData['success'];

  };
  return  result;
}



Future<bool> Register(String username, String password,String name, String surname,String phoneNumber,String mailAddress) async {
  bool result;

  final Map<String, dynamic> registerData = {
    'username': username,
    'password': password,
    'name': name,
    'surname': surname,
    'phoneNumber': phoneNumber,
    'mailAddress': mailAddress,

  };



  http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:5000/Authentication/register"),
      body: json.encode(registerData),
      headers: {'Content-Type': 'application/json; charset=utf-8'}
  );



  if (response.statusCode == 200) {
    print("yes amk");
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];
    //var userData = responseData['data'];

    //User authUser = User.fromJson(userData);



  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];

  }
  return result;
}

