import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Commentler.dart';




class Products {
  String image, title, description;
  int price, quantity, id;
  int categoryid;
  int rating;
  int size;
  List<Commentler> comments;
  dynamic discountrate;
  dynamic discprice;

  Products({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.categoryid,
    this.comments,
    this.rating,
    this.quantity,
    this.discountrate,
    this.discprice

  });


  factory Products.fromJson(Map<String, dynamic> json) {
    print("asdjasdas35");
    return Products(
      id: json["productId"] as int,
      categoryid: json["categoryId"] as int,
      title: json["productName"] as String,
      description: json["description"] as String,
      image: json["imageUrl"] as String,
      quantity: json["quantity"] as int,
      size: json["quantity"] as int,

      price: json["price"] as int,
      rating: json["rating"] as int,
      discountrate: json["discountRate"] ,
      discprice: json["discountedPrice"] ,
      //comments: json["comments"] as List,
    );
  }
}