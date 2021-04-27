import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';




class Products {
  String image, title, description;
  int price, size, id;

  Products({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,

  });


  factory Products.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Products(
      id: json['id'] as int,
      image: json['image'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      size: json['size'] as int,

    );
  }
}