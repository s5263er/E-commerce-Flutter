import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/signup_background.dart';
import 'package:flutter_app/or_divider.dart';
import 'package:flutter_app/social_icon.dart';
import 'package:flutter_app/already_have_an_account_acheck.dart';
import 'package:flutter_app/rounded_button.dart';
import 'package:flutter_app/rounded_input_field.dart';
import 'package:flutter_app/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/welcome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'textStyle.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "SIGN-UP",
              style: GoogleFonts.lato(
                textStyle: stylePost,
              )
            ),
            SizedBox(height: size.height * 0.03),
            Image.network('https://www.seekpng.com/png/full/47-475361_facebook-flat-logo-twitter-flat-logo-instagram-flat.png',height: size.height * 0.20,),

              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),




            RoundedInputField(
              hintText: "Username",
              onChanged: (value){},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),

            RoundedButton(
              text: "SIGN-UP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
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