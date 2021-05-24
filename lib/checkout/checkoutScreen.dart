
import 'package:flutter/material.dart';
import 'package:flutter_app/checkout/testAnimation.dart';
import 'package:flutter_app/details/comments.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/products/constants.dart';
import '../myStore.dart';



class checkoutScreen extends StatefulWidget {
  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<checkoutScreen> {
  bool orgAdress = false,newAdress = false;
  String newAdr;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return Scaffold(
      
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Row(
                children: [
                Checkbox(
                  activeColor: Colors.greenAccent,
                  value: orgAdress,
                  onChanged: (value) {
                    setState(() {
                      orgAdress = !orgAdress;
                      if(orgAdress == true && newAdress == true){
                        newAdress = false;
                      }
                    });
                  },
                ),
                Text('I want to use my original adress',
                    style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24,height: 1.5, color: Colors.black))
                ),


                ],
                ),
            SizedBox(height: 10,),
            Container(
                height: 100,
                width: 300,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(color: Colors.black12)
                ),
                child: Text(
                    "Gemi mahallesi genis sokak no:3 melek apartmanı kat:9 daire:25",
                    style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18,height: 1.5, color: Colors.white))
                )
            ),
            SizedBox(height: 18,),
            Row(
              children: [
                Checkbox(
                  value: newAdress,
                  onChanged: (value) {
                    setState(() {
                      newAdress = !newAdress;
                      if(newAdress == true && orgAdress == true){
                        orgAdress = false;
                      }
                    });
                  },
                ),
                Text('Another delivery address', style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24,height: 1.5, color: Colors.black))),
              ],
            ),
              SizedBox(height: 20,),
              Container(

                height: 5 * 24.0,
                width: 300,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    border: Border.all(color: Colors.white12)
                ),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  maxLines: 5,
                  onChanged: (test) {newAdr = test;},
                  style: GoogleFonts.lato(fontSize: 18, textStyle: TextStyle(height: 1.5, color: Colors.white)),
                  decoration: InputDecoration(
                  hintText: "Please Enter New Address For Delivery",
                    hintStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18,height: 1.5, color: Colors.white))
                ),
                ),
                ),
            SizedBox(height: 120,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  color: kPrimaryColor,
                  onPressed: () {
                    if(orgAdress == false && newAdress == true){
                      store.setAdress(newAdr);
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MySample();
                        },
                      ),
                    );

                  },
                  child: Text(
                      "Payment",
                      style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))
                  ),
                ),
              ],
            )
          ],
        ),
      ),
          );
  }
}
