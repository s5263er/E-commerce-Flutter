import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class APIServices{
  static String productUrl = 'http://';

  static Future fetchProduct() async{
    return await http.get(Uri.parse(productUrl));
  }

}