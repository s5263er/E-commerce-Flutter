import "package:flutter/material.dart";
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";
import 'package:flutter_app/shopping_cart/cart_body.dart';


import '../models/Products.dart';
import '../myStore.dart';
/*
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return Scaffold(
      appBar: buildAppBar(store, context),
      body: Body()
    );
  }

  AppBar buildAppBar(myStore store, BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${store.baskets.length} items",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      )
    );
  }
}

*/
/*
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<myStore>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Chip(
                      label: Text(
                        store.getTotalCost().toString(),
                        style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(store: store)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => Products(
                    store.baskets.toList()[index].id,
                    cart.items.keys.toList()[index],
                    cart.items.values.toList()[index].price,
                    cart.items.values.toList()[index].quantity,
                    cart.items.values.toList()[index].title
                ),
                itemCount: store.baskets.length,
              ),
            ),
          ],
        )
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)? null : () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<myStore>(context, listen: false).addOrder(
            widget.cart.items.values.toList(),
            widget.cart.totalAmount
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clearCart();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}*/


//farkli
class  CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
          title: Text("Your Cart"),
    ),
    body: Column(
      children: [

        Expanded(
          child: ListView.builder(
               itemCount: store.baskets.length,
                itemBuilder: (BuildContext context,int i)
                {

                  return Column(
                    children: [

                      Row(
                        children: <Widget>[
                          Expanded(flex: 2,
                            child: Image.asset(store.baskets[i].image),

                          ),
                          Expanded(flex: 2,child: Text(store.baskets[i].title + " Price: " + store.baskets[i].price.toString() + "\$")),
                          Expanded(flex: 2,child: Container(
                            decoration: BoxDecoration(
                            ),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.arrow_upward,color: Colors.green,),
                                      onPressed: () => store.addOneItemBasket(store.baskets[i]),
                                      ),
                                  Text(store.baskets[i].size.toString()),
                                  IconButton(
                                    icon: Icon(Icons.arrow_downward,color: Colors.red,),
                                    onPressed: () => store.removeBasket(store.baskets[i]),
                                  ),
                                ],
                              ),
                          )
                          ),




                        ],
                      ),
                      Divider(
                        height: 15,
                        color: kPrimaryColor,
                        thickness: 5,
                        indent: 10,
                        endIndent: 10,
                      )

                    ],

                  );

                },

          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: "Total \n",
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                children: [
                  TextSpan(
                    text: "${store.getTotalCost()} \$",
                      style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kPrimaryColor))
                  )
                ]
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              color: kPrimaryColor,
              onPressed: () {},
              child: Text(
                  "CHECK OUT",
                  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
              ),
            )
          ],

        ),


      ],
    )

    );
  }
}
/*
FlatButton(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
color: kPrimaryColor,
onPressed: () {},
child: Text(
"BUY NOW",
style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
),
),
*/