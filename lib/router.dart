import 'package:flutter/material.dart';
import 'package:flutter_app/details/details_screen.dart';
import 'package:flutter_app/search/search_history.dart';




void main() => runApp(MaterialApp(
  //home: Welcome(),
  //initialRoute: '/login',
  routes: {
    '/details': (context) => DetailsScreen(),
    '/search': (context) => Search(),
  },
));
