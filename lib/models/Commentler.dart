import 'dart:convert';
//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';




class Commentler {
  String username, comment;
  int rating;
  int productid;

  Commentler({
    this.username,
    this.productid,
    this.comment,
    this.rating,

  });


  factory Commentler.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Commentler(
      productid: json["productId"] as int,
      rating: json["like"] as int,
      username: json["commentorName"] as String,
      comment: json["description"] as String,
    );
  }
}