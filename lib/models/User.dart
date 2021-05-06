import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/myStore.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Products.dart';


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
        }

        if(!snapshot.hasData)
        {
          return Scaffold(

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
        }

        return (snapshot.data == true)
            ? MyApps()
            : Scaffold(

            backgroundColor: Colors.pinkAccent.shade100,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Username or Password is wrong please try again",
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
                        child: Text("Login Page",style: TextStyle(fontSize: 25),)
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
                        child: Text("Home Page",style: TextStyle(fontSize: 25),)
                    )
                  ],
                )

            ));


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
        }

        return (snapshot.data == true)
            ? Scaffold(

            backgroundColor: Colors.pinkAccent.shade100,
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

