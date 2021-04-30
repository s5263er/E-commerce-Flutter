import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Products> data = [];

class MyApps extends StatelessWidget {
  final String category;
  MyApps({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<Products>>(
      future: getThemes(http.Client()),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          data += snapshot.data;
        };


        return snapshot.hasData
            ? HomeScreen()
            : Scaffold(

            backgroundColor: Colors.pinkAccent,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(backgroundColor: Colors.pink,),
                    Text("Loading..."),
                  ],
                )));
      },

    );
  }
}



class myStore extends ChangeNotifier
{
  //https://mocki.io/v1/b2e00410-8e14-437f-bda8-99dd16165ee8

  List<Products> _products = [];
  List<Products> _computers = [];
  List<Products> _tvs = [];
  List<Products> _cameras = [];
  List<Products> _phones = [];
  List<Products> _baskets = [];
  Products _activeProduct = null;
  int totalCost = 0;
  String name,city;
  String username;
  bool login = false;
  myStore() {

    /* _products = [ Products(id: 1, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_1.png"),
                  Products(id: 2, title: "Belt Bag", price: 234, size: 1, description: dummyText, image: "assets/bag_2.png", ),
                  Products(id: 3, title: "Hang Top", price: 234, size: 1, description: dummyText, image: "assets/bag_3.png", ),
                  Products(id: 4, title: "Old Fashion", price: 234, size: 1, description: dummyText, image: "assets/bag_4.png",),
                  Products(id: 5, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_5.png", ),
                  Products(id: 6, title: "Office Code", price: 234, size: 1, description: dummyText, image: "assets/bag_6.png",)];*/



    _products = data;
    _computers = data;
    _tvs = data;
    _cameras = data;
    _phones = data;
    _computers = _computers.where((p) => p.categoryid == 0).toList();
    _tvs = _tvs = _tvs.where((p) => p.categoryid == 1).toList();
    _cameras = _cameras.where((p) => p.categoryid == 2).toList();
    _phones = _phones.where((p) => p.categoryid == 3).toList();

    /*_products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
    _computers = _computers.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
    _tvs = _tvs.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
    _cameras = _cameras.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
    _phones = _phones.where((element) => element.price >= globalmin && element.price <= globalmax).toList();*/

    notifyListeners();



  }

  List<Products> get computers => _computers;
  List<Products> get phones => _phones;
  List<Products> get cameras => _cameras;
  List<Products> get tvs => _tvs;




  List<Products> get products => _products;
  List<Products> get baskets => _baskets;
  Products get activeProduct => _activeProduct;

  Future<void> printData() async
  {
    final url = Uri.parse("https://mocki.io/v1/fa0a54d3-fce1-4545-a1af-b34b290843dc");
    var body = {
      "name": name,
      "city": city,
    };


  }

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
  getSortedList(List <Products> products2)
  {
    products2.sort((b,a) => a.price.compareTo(b.price));
  }

}


List<Products> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Products>((json) => Products.fromJson(json)).toList();
}

Future<List<Products>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://localhost:5000/Product/getall'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

Future<List<Products>> getThemes(http.Client client) async {
  print("deneme2");
  String url = 'http://127.0.0.1:5000/Product/getall';

  print("deneme4");
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  //print('Token : ${token}');
  //print(response);



  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    //return map2.map<Products>((json) => Products.fromJson(json)).toList();



    //return Products.fromJson(map);

    List<dynamic> data = map["data"];

    //data.fromJson();
    //print(data[4]);
    print("deneme3");
    return data.map((obj) => Products.fromJson(obj)).toList();
  } else {
    throw Exception('Failed to load themes');
  }
}

/*class Album {

  final String thumbnailUrl;

  Album({@required this.thumbnailUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      thumbnailUrl: json['url'],

    );
  }
}*/





/*class PhotosList extends StatelessWidget {
  final List<Products> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.asset(photos[index].image);
      },
    );
  }
}*/


