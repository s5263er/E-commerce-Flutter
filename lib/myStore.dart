import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_app/models/Commentler.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/Order.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'details/comments.dart';

List<Products> data = [];
List <Commentler> data2 = [];

class MyApps extends StatefulWidget {
  final String category;
  MyApps({Key key, this.category}) : super(key: key);

  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      print("futuregirdikbas");
    });




    return FutureBuilder<List<Products>>(

      future: getThemes(http.Client()),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          print("futuregirdik1");
          data += snapshot.data;
        };


        return snapshot.hasData
            ? HomeScreen()
            : Scaffold(

            backgroundColor: kPrimaryColor,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //CircularProgressIndicator(backgroundColor: Colors.pink,),
                    SpinKitFadingFour(
                      size: 100,
                      color: Colors.white12,
                    ),
                    Text(
                      "Loading...",
                      style: GoogleFonts.arimaMadurai(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),



                  ],
                )));
      },

    );
  }
}



class MyComments extends StatelessWidget {
  final int productid;
  MyComments({Key key, this.productid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context,listen: true);
    print('girdi1');


    return FutureBuilder<List<Commentler>>(
      future: getComments(http.Client(),productid),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          store.setComments(snapshot.data);
          print('girdi2');
          //print(snapshot.data.first.comment);
        };



        return snapshot.hasData
            ? Comments(productid: productid,msg: "Comment Will be Added After Admin Verification")
            : Scaffold(

            backgroundColor: kPrimaryColor,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //CircularProgressIndicator(backgroundColor: Colors.pink,),
                    SpinKitFadingFour(
                      size: 100,
                      color: Colors.white12,
                    ),
                    Text(
                      "Loading...",
                      style: GoogleFonts.arimaMadurai(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),



                  ],
                )));
      },

    );
  }
}

Future<List<Commentler>> getComments(http.Client client,int productid) async {
  String url = 'http://10.0.2.2:5000/Product/getallcomments/$productid';
  List<Commentler> boslist = [];

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  print('buraya da girdi');
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = await json.decode(response.body);
    List<dynamic> data = map["data"];

    List<Commentler> denemelisti = data.map((obj) => Commentler.fromJson(obj)).toList();
    //print(denemelisti.first.comment);

    return data.map((obj) => Commentler.fromJson(obj)).toList();
  }
  //print(response.statusCode);
  else {
    return boslist;
    throw Exception('Failed to load themes');
  }
}




class myStore extends ChangeNotifier
{
  //https://mocki.io/v1/b2e00410-8e14-437f-bda8-99dd16165ee8
  String adress;
  List <Commentler> _comments = [];
  List <Products> _main = [];
  List<Order> _orders = [];
  List<Products> _products = [];
  List<Products> _computers = [];
  List<Products> _tvs = [];
  List<Products> _cameras = [];
  List<Products> _phones = [];
  List<Products> _baskets = [];
  List<Products> _baskets2 = [];
  Products _activeProduct = null;
  int totalCost = 0;
  String name,city;
  String username;
  bool login = false;
  int shopping_cart_id;
  List <Products> _mainphone = [];
  List <Products> _maintv = [];
  List <Products> _maincomp = [];
  List <Products> _maincam = [];
  myStore() {
    _products = data;
    _main = data;
    _mainphone = data;
    _maintv = data;
    _maincam = data;
    _maincomp = data;
    _maincomp = _maincomp.where((p) => p.categoryid == 0).toList();
    _maintv = _maintv.where((p) => p.categoryid == 1).toList();
    _maincam = _maincam.where((p) => p.categoryid == 2).toList();
    _mainphone = _mainphone.where((p) => p.categoryid == 3).toList();
    _computers = data;
    _tvs = data;
    _cameras = data;
    _phones = data;
    _computers = _computers.where((p) => p.categoryid == 0).toList();
    _tvs = _tvs = _tvs.where((p) => p.categoryid == 1).toList();
    _cameras = _cameras.where((p) => p.categoryid == 2).toList();
    _phones = _phones.where((p) => p.categoryid == 3).toList();

    notifyListeners();



  }

  List<Commentler> get comments => _comments;

  List<Products> get computers => _computers;
  List<Products> get phones => _phones;
  List<Products> get cameras => _cameras;
  List<Products> get tvs => _tvs;
  List<Order> get order => _orders;
  List<Products> get maintv => _maintv;
  List<Products> get maincomp => _maincomp;
  List<Products> get maincam => _maincam;
  List<Products> get mainphone => _mainphone;
  List<Products> get main => _main;
  List<Products> get products => _products;
  List<Products> get baskets => _baskets;
  List<Products> get baskets2 => _baskets2;
  Products get activeProduct => _activeProduct;

  Products getProduct (int id){
    for(int i = 0;i<products.length ; i++){
      if(id == products[i].id){
        return products[i];
      }
    }
  }

  String getStatus (Order ord){
    if(ord.status == 0)
      return "Processing";
    else if (ord.status == 1)
      return "In-Transit";
    else
      return "Delivered";
  }

  setAdress (String Adr){
    adress = Adr;
  }

  setOrders (List<Order> ord){
    _orders = ord;
  }

  setBasket(Products p ){
    _baskets.add(p);
  }
  setProducts (List<Products> c){
    _baskets = c;
  }
  setProducts2 (List<Products> c){
    _baskets2 = c;
  }
  delProducts2 (){
    _baskets2 = [];
  }

  delProducts (){
    _baskets = [];
  }
  setFilters(){
    if(filter == true){
      _products = _products.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
      _phones = _phones.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
      _cameras = _cameras.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
      _computers = _computers.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
      _tvs = _tvs.where((element) => element.price >= globalmin && element.price <= globalmax).toList();
      if(globalasc == true)
      {
        print("asc");
        _products.sort((b,a) => a.price.compareTo(b.price));
        _computers.sort((b,a) => a.price.compareTo(b.price));
        _tvs.sort((b,a) => a.price.compareTo(b.price));
        _phones.sort((b,a) => a.price.compareTo(b.price));
        _cameras.sort((b,a) => a.price.compareTo(b.price));
        globalasc = false;
      }
      if(globaldesc == true)
      {
        _products.sort((a, b) => a.price.compareTo(b.price));
        _cameras.sort((a, b) => a.price.compareTo(b.price));
        _phones.sort((a, b) => a.price.compareTo(b.price));
        _tvs.sort((a, b) => a.price.compareTo(b.price));
        _computers.sort((a, b) => a.price.compareTo(b.price));

        print("desc");
        globaldesc = false;
      }
      print("$_products inanilmaz");}
    else{
      _products = main;
      _cameras = maincam;
      _phones = mainphone;
      _computers = maincomp;
      _tvs = maintv;
    }
  }




  setActiveProduct (Products p){
    _activeProduct = p;
  }
  setComments (List<Commentler> c){
    _comments = c;
  }



  setShoppingCartId(int a){
    shopping_cart_id = a;
  }
  Future<void> deleteItem(int Pid, String token) async {
    bool result;

    final Map<String, dynamic> addItemData = {
      'productid': Pid,
    };
    http.Response response = await http.delete(
        Uri.parse("http://10.0.2.2:5000/ShoppingCart/deletecartitem"),
        body: json.encode(addItemData),
        headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $token',}
    );

    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      print("yes delete girdik");
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];
      print(result.toString());
      //var userData = responseData['data'];

      //User authUser = User.fromJson(userData);


    } else if (response.statusCode == 400){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];

    }
    return  result;
  }
  Future<void> updateItem(int quantity,int Pid, String token) async {
    bool result;

    final Map<String, dynamic> addItemData = {
      'productid': Pid,
      'quantity': quantity,
    };

    http.Response response = await http.put(
        Uri.parse("http://10.0.2.2:5000/ShoppingCart/updatecartitem"),
        body: json.encode(addItemData),
        headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $token',}
    );

    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      print("update item girdik");
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];
      print(result.toString());
      //var userData = responseData['data'];

      //User authUser = User.fromJson(userData);


    } else if (response.statusCode == 400){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];

    }
    else if (response.statusCode == 401){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];
      print("sıkıntıyı biliyorsun");
    }
    return  result;
  }
  Future<void> addItem(int quantity,int Pid, String token) async {
    bool result;

    final Map<String, dynamic> addItemData = {
      'productid': Pid,
      'quantity': quantity
    };

    http.Response response = await http.put(
        Uri.parse("http://10.0.2.2:5000/ShoppingCart/AddCartItem"),
        body: json.encode(addItemData),
        headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $token',}
    );

    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      print("add item girdik");
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];
      print(result.toString());
      //var userData = responseData['data'];

      //User authUser = User.fromJson(userData);


    } else if (response.statusCode == 400){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];

    }
    else if (response.statusCode == 401){
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = await responseData['success'];
      print("sıkıntıyı biliyorsun");
    }
    return  result;
  }

  addOneItemBasket(Products p,int count) {
    Products found =_baskets.firstWhere((a) => a.id == p.id, orElse: () => null);

    if(login == true && baskets2.isEmpty){}
    if(login == true && found != null){
      //count += 1;
      updateItem(count + found.size, found.id, globalToken);
    }
    if(login == true && found == null){
      addItem(count, p.id, globalToken); //update item
    }

    if(login == false)
      {
        if(found != null)
        {
          found.size += count;
        }
        else{
          p.size = count;

          _baskets.add(p);
        }
      }
    //notifyListeners();
  }

  removeBasket(Products p) {
    Products found =_baskets.firstWhere((a) => a.id == p.id, orElse: () => null);
    if((found != null) && found.size == 1 && login == false)
    {
      _baskets.remove(p); //delete item
    }
    else if(login == false && found != null && found.size > 1)
    {
      found.size -= 1;//update item
    }
    if(login == true && found != null && found.size > 1){
      found.size -= 1;//update item
      updateItem(found.size, found.id, globalToken);
    }
    else if((found != null) && found.size == 1 && login == true)
      {
        deleteItem(found.id,globalToken);
      }
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
  String url = 'http://10.0.2.2:5000/Product/getall';

  /*Future.delayed(const Duration(seconds: 3), () {
    print("delay 5 sn");
  });
  print("delay 5sn biter");*/

  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    print("yes");

    return data.map((obj) => Products.fromJson(obj)).toList();
  } else {
    print(response.statusCode);
    print("no");
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