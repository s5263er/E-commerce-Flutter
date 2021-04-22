import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../models/Products.dart';
import '../myStore.dart';


class  CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);

    return Scaffold(
    appBar: AppBar(
          title: Text("Cart"),
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
                                      icon: Icon(Icons.add,color: Colors.green,),
                                      onPressed: () => store.addOneItemBasket(store.baskets[i]),
                                      ),
                                  Text(store.baskets[i].size.toString()),
                                  IconButton(
                                    icon: Icon(Icons.delete,color: Colors.red,),
                                    onPressed: () => store.removeBasket(store.baskets[i]),
                                  ),
                                ],
                              ),
                          )
                          ),



                        ],
                      ),

                    ],
                  );
                },
          ),
        ),
        Container(
          height: 50,
            width: 100,
            alignment: Alignment.bottomRight,
            child: Text(store.getTotalCost().toString()),

        ),
      ],
    )

    );
  }
}

