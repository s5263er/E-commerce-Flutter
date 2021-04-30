import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/details/details_screen.dart';
import 'package:flutter_app/login_background.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:flutter_app/signup_screen.dart';
import 'package:flutter_app/already_have_an_account_acheck.dart';
import 'package:flutter_app/rounded_button.dart';
import 'package:flutter_app/rounded_input_field.dart';
import 'package:flutter_app/rounded_password_field.dart';
import 'package:flutter_app/welcome.dart';
import 'package:provider/provider.dart';
import 'textStyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/myStore.dart';



class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    String username = "";
    String password = "";
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child:  RoundedButton(
                  text: "BACK",
                  press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WelcomeScreen();
                      },
                    ),
                  );},
                ),
              ),
            ),

            Text(
              "LOGIN",
              style: GoogleFonts.lato(
                textStyle: stylePost,

              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset('logo.png',height: size.height * 0.20,),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (valued) { username = valued;},
            ),
            RoundedPasswordField(
              onChanged: (value) {password = value;},
            ),
            RoundedButton(
                text: "LOGIN",

                press: () {

                  if(username == null && password == null || username.isEmpty  && password.isEmpty)
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Username and Password Cannot be Empty')));
                  }
                  else if (password == null || password.isEmpty){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Password Cannot be Empty')));
                  }
                  else if (username == null || username.isEmpty)
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Username Cannot be Empty')));
                  }
                  else{
                    /*ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(duration: Duration(seconds: 3),content: Text('Redirecting...')));*/
                    store.username = username;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LogApp(username: username, password: password,);
                        },
                      ),
                    );
                  }
                }

            ),

            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/details/details_screen.dart';
import 'package:flutter_app/login_background.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/products/home_screen.dart';
import 'package:flutter_app/signup_screen.dart';
import 'package:flutter_app/already_have_an_account_acheck.dart';
import 'package:flutter_app/rounded_button.dart';
import 'package:flutter_app/rounded_input_field.dart';
import 'package:flutter_app/rounded_password_field.dart';
import 'package:flutter_app/welcome.dart';
import 'package:http/http.dart';
import 'models/Customer.dart';
import 'textStyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List <Customer> userinfo = [];

class Body extends StatefulWidget {

   Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Customer customer;

  @override
  void initState(){
    super.initState();
    customer = new Customer();
  }

  @override
  Widget build(BuildContext context) {
    //login2();
    //loginData();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child:  RoundedButton(
                  text: "BACK",
                  press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WelcomeScreen();
                      },
                    ),
                  );},
                ),
              ),
            ),

            Text(
              "LOGIN",
              style: GoogleFonts.lato(
                textStyle: stylePost,

              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.network('https://www.seekpng.com/png/full/47-475361_facebook-flat-logo-twitter-flat-logo-instagram-flat.png',height: size.height * 0.20,),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) => customer.mail = value,
            ),
            RoundedPasswordField(
              onChanged: (value) => customer.pass = value,
            ),
            RoundedButton(
              text: "LOGIN",

              press: () {
                print(customer.toJson());
                print(userinfo);
                //SendLogin(customer.mail,customer.pass);

                //print(LoginResponseModel.fromJson());

              Navigator.push(
                context,
                   MaterialPageRoute(
                        builder: (context) {
                    return MyApps();
                                    },
                      ),
                    );},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
void login2() {
  var headers = {
    "Content-Type": "application/json",
  };

  final body = {
    "username": "Erdem2",
    "password": "zaza"
  };

  var response = http.post(
    Uri.parse("http://localhost:5000/Authentication/login"),
    headers: headers,
    body: jsonEncode(body),
  );

  print('Response status: ${response.then((value) => null)}');
}

final body = {
  "username": "Erdem2",
  "password": "zaza"
};

/*
void loginData() {
  String myurl = 'http://localhost:5000/Authentication/login';
  http.post(Uri.parse(myurl),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body)).then((response) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  });
}*/

Future<Customer> SendLogin(String email, String pass) async {
  String myurl = "http://localhost:5000/Authentication/login";
  final response = await http.post(
    Uri.parse(myurl),
    headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    },
    body: jsonEncode(body),
    );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return Customer.fromJson(jsonDecode(response.body));
  } else {
    print('error');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CustomerTaker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Customer>>(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {

        if (snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          userinfo += snapshot.data;
        };
        print("asdjasdas");
        print(snapshot.data);
        print(userinfo);
        return snapshot.hasData
            ? HomeScreen()
            : Scaffold(

            backgroundColor: Colors.pinkAccent,
            body:
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(backgroundColor: Colors.pink,),
                    Text("Loading..."),
                  ],
                )));
      },

    );
  }
}

List<Customer> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
}

Future<List<Customer>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse("http://localhost:5000/Authentication/login"));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}*/