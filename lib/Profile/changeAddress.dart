import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/details/comments.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../textStyle.dart';

Future<String> getAddr() async {
  String url = 'http://10.0.2.2:5000/Customer/GetById';


  final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',});
  print('buraya da girdi');
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = await json.decode(response.body);
    List<dynamic> data = map["data"];

    User adres = data.map((obj) => User.fromJson(obj)) as User;
    //print(denemelisti.first.comment);
    return adres.address;

  }
  //print(response.statusCode);
  else{
    print("adresi alamiyok");
  }
}

Future<bool> SendAddr(String Addr) async {
  bool result;

  final Map<String, dynamic> registerData = {
    'address': Addr,
  };



  http.Response response = await http.put(
      Uri.parse("http://10.0.2.2:5000/Customer/ChangeAddress"),
      body: json.encode(registerData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken',}
  );

  if (response.statusCode == 200) {
    print("yes amk");
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];
    //var userData = responseData['data'];

    //User authUser = User.fromJson(userData);



  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];

  }
  return result;
}

class changeAddr extends StatelessWidget {
  String erdem;

  changeAddr({Key key,this.erdem}) : super(key: key);
  String newAdr;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Change Address",
            style: GoogleFonts.lato(
              textStyle: styleAppBar,
            ),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-home-address-of-the-current-residence-image_1132241.jpg',height: 300,width: 300,),

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
                  hintText: erdem == null?"You have not registered your address":erdem,
                  hintStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18,height: 1.5, color: Colors.white))
              ),
            ),
    ),
            AnimatedButton(
              color: kPrimaryColor,
              shadowDegree: ShadowDegree.dark,
              child: Text(
                "Change My Address",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),

                ),
              ),
              onPressed: (){
                SendAddr(newAdr);
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: 'Success',
                  text: 'Address change completed successfully!',
                  confirmBtnColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor,
                  confirmBtnText: "OK",
                  loopAnimation: false,
                );
              },
            ),
          ],
        ),
      ));
  }
}
