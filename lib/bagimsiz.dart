import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  User({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.mailAddress,
    this.phoneNumber,

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

Future<Map<String, dynamic>> login(String username, String password) async {
  var result;

  final Map<String, dynamic> loginData = {
    'username': username,
    'password': password
  };



  http.Response response = await http.post(
      Uri.parse("http://127.0.0.1:5000/Authentication/login"),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json; charset=utf-8'}
  );


  print(response.headers["location"]);
  if (response.statusCode == 200) {
    print("yes amk");
    final Map<String, dynamic> responseData = json.decode(response.body);

    //var userData = responseData['data'];

    //User authUser = User.fromJson(userData);


    result = {'status': true, 'message': 'Successful', 'user': "authUser"};
  } else {
    final getResponse = await http.get(Uri.parse(response.headers["location"]));
    print('getResponse.statusCode:' + getResponse.statusCode.toString());
    print(response.statusCode.toString());
    result = {
      'status': false,
      //'message': json.decode(response.body)
    };
  }
  return result;
}




void main() {
  bool followRedirects = true;
  HttpOverrides.global = new MyHttpOverrides();
  login("Erdem2", "zaza");

}