

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Profile/changePass.dart';
import 'package:flutter_app/details/profilebody.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:flutter_app/textStyle.dart';
const colorizeTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 40,
  letterSpacing: -1,
  fontStyle: FontStyle.normal,
);
const waveTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w600,
  fontSize: 20,
  letterSpacing: -1,
  fontStyle: FontStyle.italic,
);
const colorizeColors = [
  Colors.black,
  Colors.lightGreen,
  Colors.lightGreenAccent,
];

class PaymentSuccess extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<PaymentSuccess> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 7),
            () => Navigator.push( context, MaterialPageRoute( builder: (context) => MyApps()), ).then((value) => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.network("https://firstatlanticcommerce.com/wp-content/uploads/2020/07/HTTPS-Secure-1024x577.jpg",height: 100,width: 80,)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText("Payment Verified...", textStyle: colorizeTextStyle, colors: colorizeColors,speed: Duration(milliseconds: 800)),
                ],
                //isRepeatingAnimation: true,

              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText("Directing to main page...",textStyle:waveTextStyle),
                ],
                isRepeatingAnimation: true,

              ),
            ],
          ),
        ],
      ),
    );
  }
}