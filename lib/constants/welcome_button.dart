import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final BoxDecoration decoration;
  final Color textColor;
  const WelcomeButton({
    Key key,
    @required this.onPress,
    @required this.textColor,
    @required this.decoration,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: decoration,
        // margin:
        //     EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
