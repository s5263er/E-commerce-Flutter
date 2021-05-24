import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Commentler.dart';



class Order {
  String createDate,address;
  int customerId, quantity, id,status,productId;
  double price;

  Order({
    this.id,
    this.createDate,
    this.customerId,
    this.price,
    this.productId,
    this.status,
    this.address,
    this.quantity,
  });


  factory Order.fromJson(Map<String, dynamic> json) {
    print("asdjasdas2");
    return Order(
      id: json["id"] as int,
      createDate: json["createDate"] as String,
      customerId: json["customerId"] as int,
      status: json["status"] as int,
      productId: json["productId"] as int,
      quantity: json["quantity"] as int,

      price: json["price"] as double,
      address: json["address"] as String,

    );
  }
}