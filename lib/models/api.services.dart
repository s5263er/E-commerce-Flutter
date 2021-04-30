import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter_app/models/Customer.dart';
import 'package:http/http.dart' as http;


class APIServices{
  static String productUrl = 'http://';

  Future<LoginResponseModel> login (Customer customer) async{
    String url = "http://localhost:5000/Authentication/login";

    final response = await http.post(Uri.parse(url), body: customer.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
