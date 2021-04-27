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
import 'textStyle.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",

              press: () {
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