import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/Products.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Color"),
              Row(
                children: <Widget>[
                  ColorDot(color: Color(0xFF61615E),),
                  ColorDot(color: Color(0xFF000000),),
                ],
              )
            ],
          ),
        ),
        Expanded(

          child: RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black12),
                  children: [
                    TextSpan(text: "Size\n"),
                    TextSpan(
                      text: "${product.size} inch",
                      style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                    )
                  ]
              )),
        )
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;


  const ColorDot({
    Key key,
    this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: kDefaultPaddin/4, right: kDefaultPaddin /2),
        padding: EdgeInsets.all(2.5),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
            )
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        )
    );
  }
}