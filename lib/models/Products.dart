import 'package:flutter/material.dart';

class Products {
  String image, title, description;
  int price, size, id;
  Color color;
  Products({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,

  });
}

List<Products> products = [
  Products(
      id: 1,
      title: "Office Code",
      price: 234,
      size: 1,
      description: dummyText,
      image: "assets/bag_1.png",
      color: Colors.grey),

  Products(
      id: 2,
      title: "Belt Bag",
      price: 234,
      size: 1,
      description: dummyText,
      image: "assets/bag_2.png",
      color: Colors.grey),
  Products(
      id: 3,
      title: "Hang Top",
      price: 234,
      size: 1,
      description: dummyText,
      image: "assets/bag_3.png",
      color: Colors.grey),
  Products(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 1,
      description: dummyText,
      image: "assets/bag_4.png",
      color: Colors.grey),
  Products(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 1,
      description: dummyText,
      image: "assets/bag_5.png",
      color: Colors.grey),
  Products(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 1,
    description: dummyText,
    image: "assets/bag_6.png",
    color: Colors.grey,
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
