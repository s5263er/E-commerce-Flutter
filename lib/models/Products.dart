import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Commentler.dart';




class Products {
  String image, title, description;
  int price, size, id;
  int categoryid;
  int rating;
  List<Commentler> comments;

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

  });


  factory Products.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Products(
      id: json["productId"] as int,
      categoryid: json["categoryId"] as int,
      title: json["productName"] as String,
      description: json["description"] as String,
      image: json["imageUrl"] as String,
      size: json["quantity"] as int,

      price: json["price"] as int,
      rating: json["rating"] as int,
      //comments: json["comments"] as List,

    );
  }
}