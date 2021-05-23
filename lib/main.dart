import 'package:flutter/material.dart';
import 'package:flutter_app/welcome.dart';
import 'package:flutter_app/products/constants.dart';

import 'package:flutter_app/textStyle.dart';
import 'package:provider/provider.dart';

import 'myStore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) {return myStore();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: MyApps(),
      ),
    );
  }
}