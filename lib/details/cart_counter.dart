import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/shopping_cart/cartScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/products/constants.dart';

import '../myStore.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
  const CartCounter({
    Key key,
    @required this.no
  }) : super(key: key);
  final int no;
}

class _CartCounterState extends State<CartCounter> {


  int numOfItems = 0;
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    getCart(globalToken);

    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {

            if(numOfItems > 0)
            {
              setState(() {
                numOfItems--;
                store.removeBasket(store.activeProduct);
              });
            }

          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 /2),
          child: Text(
            numOfItems.toString().padLeft(2,"0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numOfItems++;
              store.addOneItemBasket(store.activeProduct,numOfItems);
              print(store.baskets);

            });
          },
        ),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),

      ),
    );
  }
}
