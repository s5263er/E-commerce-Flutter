/*

import 'dart:js';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/size_config.dart';
import "package:provider/provider.dart";

import '../models/Products.dart';
import '../myStore.dart';

class Body extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    Expanded(
        child: ListView.builder(
          itemCount: store.baskets.length,
            itemBuilder: (BuildContext context,int i){
              return CartItemCard(store: store);
            }

        )
    );

  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    @required this.store,
  }) : super(key: key);

  final myStore store;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),

              ),
              child: Image.asset(store.baskets[i].image),
            ),
          ),

        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.baskets[i].title,
              style: TextStyle(fontSize: 16, color: Colors.black),
              maxLines: 2,
              ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                  text: "\$${store.baskets[i].price}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                children: [
                  TextSpan(
                    text: " x${store.baskets[i].size}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  )
                ]
              )
            )
          ],
        )
      ],
    );
  }
}
*/