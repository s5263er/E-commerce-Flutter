library globals;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Products.dart';


int globalInt = 0;
bool globalBoolean = true;
String globalString = "id1";
double globalDouble= 10.0;
double globalmax = 5000.0;
double globalmin = 0;
int pressed = 0;
List <Products> queryproducts = [];
bool filter = false;

String globalToken = "";

bool globalasc = false;
bool globaldesc = false;

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

//const kPrimaryColor = Color(0xFF2D0C40);
//const kPrimaryLightColor = Color(0xFF8B5CBD);
const kPrimaryColor = Color(0xFF1D1A1A);
const kPrimaryLightColor = Colors.black54;

const kDefaultPaddin = 20.0;


