import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/details/add_to_cart.dart';
import 'package:flutter_app/details/color_and_size.dart';
import 'package:flutter_app/details/product_title_with_image.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../myStore.dart';
import 'cart_counter.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';


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

class DetailBody extends StatefulWidget {

  const DetailBody({Key key}) : super(key: key);

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  int numOfItems = 0;
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(top:size.height*0.12, left: kDefaultPaddin, right: kDefaultPaddin),
                  height: 500,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: store.activeProduct),
                      SizedBox(height: kDefaultPaddin/4),
                      Description(product: store.activeProduct),
                      SizedBox(height: kDefaultPaddin/4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              buildOutlineButton(
                                icon: Icons.remove,
                                press: () {
                                  if(numOfItems > 0)
                                  {
                                    setState(() {
                                      numOfItems--;
                                      //store.removeBasket(store.activeProduct);
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
                                    if(numOfItems < store.activeProduct.quantity)
                                    {
                                      numOfItems++;
                                      //store.addOneItemBasket(store.activeProduct,numOfItems);

                                    }
                                    else {
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        title: 'Oops...',
                                        text: '${store.activeProduct.quantity} items left in stock',
                                        confirmBtnColor: kPrimaryColor,
                                        backgroundColor: kPrimaryColor,
                                        confirmBtnText: "OK",
                                        loopAnimation: false,
                                      );
                                    }
                                    //store.addOneItemBasket(store.activeProduct);
                                    print(store.baskets);

                                  });
                                },
                              ),
                            ],
                          ),
                          Text(


                            'Product comments',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                letterSpacing: -1,
                                fontStyle: FontStyle.italic,
                              ),

                            ),
                          ),
                          Container(

                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
                              ),
                              child: new IconTheme(
                                  data: new IconThemeData(color: Colors.white),
                                  child: IconButton(icon: Icon(Icons.comment_rounded,size: 30),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return MyComments(productid: store.activeProduct.id);
                                            },
                                          ),
                                        );
                                      }
                                  )


                              ))],
                      ),
                      SizedBox(height: kDefaultPaddin/4),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: Row(
            children: <Widget> [
              Container(
                margin: EdgeInsets.only(right: kDefaultPaddin),
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: kPrimaryColor)
                ),
                child: IconButton(
                  icon: SvgPicture.asset("assets/icons/add_to_cart.svg",color: kPrimaryColor,),
                  onPressed: () {
                    print("BU KADARRR $numOfItems");

                    if (numOfItems > 0) {
                      
                      //
                      store.addOneItemBasket(store.activeProduct,numOfItems);
                      if(store.login == true){
                      store.setBasket(store.activeProduct);}

                      /*for (int i = 0; i < numOfItems; i++) {
                        if(i == 0){
                          print("amac eklemek basta 0 item");
                          store.addOneItemBasket(store.activeProduct);}
                        else{
                          print("amac update product id = ${store.activeProduct.id}");
                          store.addOneItemBasket(store.activeProduct);
                          //i = numOfItems;
                        }
                      }*/

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Item added successfully')));
                    }
                    else{
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('You cannot add 0 items')));
                    }
                  }
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: kPrimaryColor,
                    onPressed: () {
                      //showAlertDialog('title', 'msg');
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Item added successfully')));
                    },
                    child: Text(
                        "BUY NOW",
                        style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                  ),
                ),
              )

            ],
          ),
        ),

                    ],
                  )
                ),
                ProductTitleWithImage(product: store.activeProduct)
              ],
            )
          )
        ],
      ),
    );
  }
}









