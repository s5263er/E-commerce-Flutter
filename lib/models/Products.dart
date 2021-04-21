import 'package:flutter/material.dart';

class Products {
  final String title, description;
  final String image;
  final int price, id,size;
  final Color color;
  //final NetworkImage image;

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

List <Products> _cartList = List<Products>();

List <Products> products = [
  Products(
    id: 1,
    title: "MacBook Pro",
    price: 1299,
    size: 13,
    description: "Apple M1 chip with 8-core CPU, 8-core GPU, and 16-core Neural Engine 8GB unified memory 256GB SSD storage 13-inch Retina display with True Tone Magic Keyboard Touch Bar and Touch ID Force Touch trackpad Two Thunderbolt / USB 4 ports",
    //image: NetworkImage('https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202011?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1613672894000'),
    image : "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202011?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1613672894000",
    color: Color(0x727272),
  )
];

//https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202011?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1613672894000","https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-silver-select-202011?wid=452&hei=420&fmt=jpeg&qlt=95&.v=1613673938000"