import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
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

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Size size;


  int attemptCount;
  String mail;
  String userName;
  String pass;
  final _formKey = GlobalKey<FormState>();

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }




  @override
  void initState() {
    super.initState();
    print('initState called');
    attemptCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('Build called');


    return Scaffold(

      appBar: AppBar(
        title: Text(
            "SIGN-UP",
            style: GoogleFonts.lato(
              textStyle: styleAppBar,
            )
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0.0,
      ),



      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*SizedBox(
              width: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child: RoundedButton(
                  text: "BACK",
                  press: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return WelcomeScreen();
                      },
                        ),
                    );
                  },
                ),
              ),
            ),*/
            SizedBox(height: size.height * 0.02),
            Image.network('https://www.seekpng.com/png/full/47-475361_facebook-flat-logo-twitter-flat-logo-instagram-flat.png',height: size.height * 0.2,),
            SizedBox(height: size.height*0.0),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',

                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if(!EmailValidator.validate(value)) {
                              return 'The e-mail address is not valid';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            mail = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 0.0,),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'Username',
                            //labelText: 'Username',
                            labelStyle: stylePost,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryLightColor),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your username';
                            }
                            if(value.length < 4) {
                              return 'Username is too short';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                             userName = value;
                          },
                        ),
                      ),
                    ],
                  ),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',

                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 0,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {

                            if(_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              //showAlertDialog("Action", 'Button clicked');
                              setState(() {
                                attemptCount += 1;
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Signed-up')));
                            }

                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                            child: Text(
                              'Sign-Up',
                              style: styleButton,

                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}