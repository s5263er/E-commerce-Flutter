import 'package:flutter/material.dart';
import 'package:flutter_app/models/Products.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(product.description,style: GoogleFonts.lato(textStyle: TextStyle(height: 1.5, color: Colors.black)),),
    );
  }
}