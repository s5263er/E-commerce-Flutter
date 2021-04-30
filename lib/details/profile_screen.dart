import 'package:flutter/material.dart';
import 'package:flutter_app/details/profilebody.dart';
import 'package:google_fonts/google_fonts.dart';

import '../textStyle.dart';


class ProfileScreen extends StatelessWidget {
  String username;

  ProfileScreen({Key key,this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile of $username",
          style: GoogleFonts.lato(
            textStyle: styleAppBar,
          ),
        ),
      ),
      body: ProfileBody(),

    );
  }
}

