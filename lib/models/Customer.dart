import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginResponseModel{
  final String token;
  final String error;
  final bool success;

  LoginResponseModel({this.token,this.error,this.success});

  factory LoginResponseModel.fromJson(Map<String,dynamic> json){
    return LoginResponseModel(token: json["data"] != null ? json["data"]: "", error: json["message"], success: json["success"]);
  }

}




class Customer {
  String mail, nick, pass;
  int id;

  Customer({
    this.pass,
    this.id,
    this.nick,
    this.mail
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Customer(
      id: json["id"] as int,
      mail: json["mailAddress"] as String,
      pass: json["password"] as String,
      nick: json["username"] as String,

    );
  }


  /*factory Customer.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Customer(
        id: json['id'] as int,
        nick: json['username'] as String,
        mail: json['mailAddress'] as String
    );
  }*/

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "mailAddress": mail,
      "username": nick,
      "password": pass,
    };
    return map;
  }

  /*Map<String, dynamic> fromJson() {
    Map<String, dynamic> map = {
      id: json['id'] as int,
      mail: json['mailAdress'] as String,
      pass: json['password'] as String,
      nick: json['username'] as String,
    };
    return map;
  }
  */


}



