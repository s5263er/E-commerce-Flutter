import "package:flutter/material.dart";
import 'package:flutter_app/models/Products.dart';
import 'package:provider/provider.dart';


class myStore extends ChangeNotifier
{


  List<Products> _products = [];
  List<Products> _baskets = [];
  Products _activeProduct = null;
  int totalCost = 0;
  myStore() {

    _products = [ Products(id: 1, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_1.png", color: Colors.grey),
                  Products(id: 2, title: "Belt Bag", price: 234, size: 1, description: dummyText, image: "assets/bag_2.png", color: Colors.grey),
                  Products(id: 3, title: "Hang Top", price: 234, size: 1, description: dummyText, image: "assets/bag_3.png", color: Colors.grey),
                  Products(id: 4, title: "Old Fashion", price: 234, size: 1, description: dummyText, image: "assets/bag_4.png", color: Colors.grey),
                  Products(id: 5, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_5.png", color: Colors.grey),
                  Products(id: 6, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_6.png", color: Colors.grey,)];
    notifyListeners();



  }

  List<Products> get products => _products;
  List<Products> get baskets => _baskets;
  Products get activeProduct => _activeProduct;

  setActiveProduct (Products p){
    _activeProduct = p;
  }

  addOneItemBasket(Products p) {
    Products found =_baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    if(found != null)
    {
      found.size += 1;
    }
    else{
      _baskets.add(p);
    }
    notifyListeners();
  }

  removeBasket(Products p) {
    Products found =_baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    if((found != null) && found.size == 1)
    {
      _baskets.remove(p);
    }
    else
      {
        found.size -= 1;
      }
    notifyListeners();
  }

  getBasketQty(){
    int total = 0;
    for (int i=0;i<baskets.length;i++)
    {
      total += baskets[i].size;
    }
    return total;
  }

  getTotalCost()
  {
    int total = 0;
    for (int i=0;i<baskets.length;i++)
    {
      total += baskets[i].size * baskets[i].price;
    }
    return total;
  }

}



