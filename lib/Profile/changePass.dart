import 'dart:convert';
import 'package:animated_button/animated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Profile/changePassFutureBuilder.dart';
import 'package:flutter_app/details/profilebody.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/myStore.dart';
import 'package:flutter_app/signup_background.dart';
import 'package:flutter_app/or_divider.dart';
import 'package:flutter_app/signup_screen.dart';
import 'package:flutter_app/social_icon.dart';
import 'package:flutter_app/already_have_an_account_acheck.dart';
import 'package:flutter_app/rounded_button.dart';
import 'package:flutter_app/rounded_input_field.dart';
import 'package:flutter_app/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/welcome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/products/constants.dart';
import 'package:http/http.dart' as http;
import '../textStyle.dart';

Future<bool> ChangePass(String username, String password,String newpassword) async {
  bool result;

  final Map<String, dynamic> registerData = {
    'username': username,
    'password': password,
    'newpassword': newpassword
  };



  http.Response response = await http.put(
      Uri.parse("http://10.0.2.2:5000/Authentication/changepassword"),
      body: json.encode(registerData),
      headers: {'Content-Type': 'application/json; charset=utf-8','Authorization': 'Bearer $globalToken'}
  );



  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];
    print("awesomegir");
  } else if (response.statusCode == 400){
    final Map<String, dynamic> responseData = json.decode(response.body);
    result = responseData['success'];


  }
  print("$result change password http response");
  return result;
}






class changePass extends StatefulWidget {
  @override
  _changePassState createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  final _form = GlobalKey<FormState>();
  String username, password, newpassword;

  bool haketti= false;
  bool haketti2;
  void _saveForm(context) {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChangePass2(username: username,newpassword: newpassword,password: password,);
          },
        ),
      );
    }
  }

    @override
    Widget build(BuildContext context) {

        Size size = MediaQuery
          .of(context)
          .size;
      return Scaffold(
        appBar: buildAppBar(context),
        body: Background(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Change Your Password",
                      style: GoogleFonts.lato(
                        textStyle: stylePost,
                      )
                  ),
                  SizedBox(height: size.height * 0.03),

                  TextFormField(
                    cursorColor: kPrimaryColor,

                    decoration: InputDecoration(
                      hoverColor: kPrimaryColor,
                      icon: Icon(
                        Icons.person_pin_circle,
                        color: kPrimaryColor,
                      ),
                      labelText: "Username",
                        border:  OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                          ),
                        ),
                        fillColor: kPrimaryColor
                    ),
                    onChanged: (valueU) {username = valueU;},
                    validator: (text){
                      if (!(text.length > 5) && (text.isNotEmpty || text != null)) {
                        return "Your username must be 5 characters long";
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: size.height * 0.03),


                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      labelText: "Password",
                        border:  OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                          ),
                        ),
                        fillColor: kPrimaryColor
                    ),
                    onChanged: (valueP) {
                      password = valueP;
                    },
                    validator: (text) {
                      if (!(text.length > 5) &&
                          (text.isNotEmpty || text != null)) {
                        return "Your password must be 5 characters long";
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      labelText: "New Password",
                      //border: UnderlineInputBorder(),
                      border:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                        ),
                      ),
                      fillColor: kPrimaryColor
                      ),

                    onChanged: (valueP) {
                      newpassword = valueP;
                    },
                    validator: (text) {
                      if (!(text.length > 5) &&
                          (text.isNotEmpty || text != null)) {
                        return "Your new password must be 5 characters long";
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: size.height * 0.03),

                  AnimatedButton(
                    color: kPrimaryColor,
                    shadowDegree: ShadowDegree.dark,
                    child: Text(
                      "Change Password",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),
                    onPressed: (){
                      _saveForm(context);

                    },
                  ),

                  /*RoundedButton(
                    text: "Click to save your new password",
                    press: () {
                      _saveForm(context);
                      //ChangePass2(username: username,password: password,newpassword: newpassword,);
                      print("girdik aq");
                    }

                  ),*/
                  SizedBox(height: size.height * 0.03),

                ],
              ),
            ),
          ),
        ),
      );
    }
}





AppBar buildAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Change Password",
        style: GoogleFonts.lato(
          textStyle: styleAppBar,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () =>Navigator.pop(context),
      ),
      actions: <Widget> [
        SizedBox(width: 10),
      ]



  );
}
