import 'package:flutter/material.dart';
import 'package:flutter_app/details/details_screen.dart';
import 'package:flutter_app/models/Commentler.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/products/constants.dart';




import 'package:flutter/cupertino.dart';

import 'package:flutter_app/myStore.dart';


import '../login_screen.dart';
import '../myStore.dart';
import '../products/constants.dart';
import '../textStyle.dart';

int rate = 0 ;
String userComment = "";

class Comments extends StatefulWidget {

  final int productid;
  String msg;

  Comments({
    Key key,
    @required this.productid,
    @required this.msg,
  }) : super(key: key);




  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  //int productid;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
    var store = Provider.of<myStore>(context);
    List <Commentler> _comments = store.comments;
    List <Products> _products = store.products;
    print(store.products.first.title);
    print(store.comments);
    print(_comments);
    _products = _products.where((element) => element.id == 1).toList();


    return Scaffold(

      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <CustomListItem> [
                      CustomListItem(thumbnail: _products[0].image, user: _comments[index].username, comment: _comments[index].comment, likes: _comments[index].rating)

                    ]
                );
              },
            ),
          ),
          SizedBox(height: 100,)
        ],
      ),


      bottomSheet: Container(
        width: 500,
        height: 100,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              allowHalfRating: false,
              onRatingUpdate: (rating) => {rate = rating.toInt()},
              initialRating: 1,
              itemCount: 5,
              itemBuilder: (context, index) {

                switch (index) {
                  case 0:
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,

                    );
                  case 1:
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,

                    );
                  case 2:
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,

                    );
                  case 3:
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,

                    );
                  case 4:
                    return Icon(
                      Icons.star,
                      color: Colors.yellow,

                    );
                }
              },
            ),
            Container(
                height: 50.0,
                width: 500,
                padding: EdgeInsets.symmetric(vertical: 2.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // First child is enter comment text input
                      Container(
                        height: 50,
                        width: 400,
                        child: TextFormField(
                          onChanged: (myComment) {userComment = myComment;},
                          autocorrect: false,
                          decoration: new InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              iconSize: 20.0,
                              onPressed: () {

                                Navigator.pop(context);
                                setState(() {
                                  final snackBar = SnackBar(key: widget.key,content: Text(widget.msg),backgroundColor: kPrimaryColor,);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CommentsApp(username: store.username, rate: rate,pId: store.activeProduct.id,comment: userComment,token: globalToken,);
                                    },
                                  ),
                                );
                              },
                            ),
                            hintText: "Add Comment",
                            labelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                            fillColor: Colors.blue,
                            border: OutlineInputBorder(
                              // borderRadius:
                              //     BorderRadius.all(Radius.zero(5.0)),
                                borderSide:
                                BorderSide(color: Colors.purpleAccent)),
                          ),
                        ),
                      ),

                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key key,
    @required this.thumbnail,
    @required this.comment,
    @required this.user,
    @required this.likes,
  }) : super(key: key);

  final String thumbnail;
  final String comment;
  final String user;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 50,
              width: 50,
              child: Icon(Icons.person,size: 50,)
          ),
          Expanded(
            child: _VideoDescription(
              comment: comment,
              user: user,
              like: likes,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    @required this.comment,
    @required this.user,
    @required this.like,
  }) : super(key: key);

  final String comment;
  final String user;
  final int like;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user,
                style: GoogleFonts.lato(
                  textStyle: stylePost,

                ),
              ),

              RatingBar.builder(
                initialRating: like.truncateToDouble(),
                itemCount: 5,
                itemBuilder: (context, index) {

                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,

                      );
                    case 1:
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,

                      );
                    case 2:
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,

                      );
                    case 3:
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,

                      );
                    case 4:
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,

                      );
                  }
                },
              ),

            ],
          ),


          SizedBox(height: 10,),
          Text(
              comment,
              style: GoogleFonts.abel(textStyle: TextStyle(color: Colors.black,fontSize: 17))
          ),
          //const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),

        ],
      ),
    );
  }
}




AppBar buildAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Comments",
        style: GoogleFonts.lato(
          textStyle: styleAppBar,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () =>Navigator.pop(context),
      ),
      actions: <Widget> [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CartScreen();
                },
              ),
            );
          },
        ),
        SizedBox(width: 10),
      ]



  );
}

Future<bool> addcomment(String username, int rate,String comment, int Pid, String token) async {
  bool result;


  final Map<String, dynamic> commentData = {
    'description': comment,
    'like': rate,
    'productid': Pid,
    'commentorname': username
  };

  print(commentData);

  print("comment added");

  http.Response response = await http.put(
      Uri.parse("http://127.0.0.1:5000/Product/AddComment"),
      body: json.encode(commentData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $token',}
  );

  print(response.statusCode.toString());

  if (response.statusCode == 200) {
    print("yes amk");
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



class CommentsApp extends StatelessWidget {
  final String username;
  final String comment;
  final int pId;
  final int rate;
  final String token;


  CommentsApp({Key key,this.username,this.comment,this.pId,this.rate,this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return FutureBuilder<bool>(
      future: addcomment(username,rate,comment,pId,token),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        print(snapshot.data);
        if(snapshot.hasData){
          print("çalışıyor gibi");
        }

        if(!snapshot.hasData)
        {
          return Scaffold(

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
        }

        return (snapshot.data == true)
            ? Comments(msg: "Comment Will Be Added After Admin Vertification", productid: store.activeProduct.id,)
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