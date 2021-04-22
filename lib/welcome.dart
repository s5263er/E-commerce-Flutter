import 'package:flutter/material.dart';
import 'package:flutter_app/welcome_body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/textStyle.dart';
import 'package:provider/provider.dart';
import 'myStore.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "AppBar",
            style: GoogleFonts.lato(
              textStyle: styleAppBar,
            ),
        ),

      ),
      body: Body(),
    );
  }
}