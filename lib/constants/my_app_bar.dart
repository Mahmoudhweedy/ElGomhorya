import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class MyAppBar extends StatelessWidget {
  final double radius;
  final String screenName;
  final Function onPress;
  final bool back;
  final bool isDrawer;
  const MyAppBar({
    Key key,
    @required this.radius,
    @required this.screenName,
    @required this.onPress,
    this.back = true,
    this.isDrawer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(15),
        getProportionateScreenHeight(15),
        getProportionateScreenHeight(15),
        0,
      ),
      height: SizeConfig.screenHeight * .15,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFFEC40D),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(getProportionateScreenWidth(radius)),
            bottomLeft: Radius.circular(getProportionateScreenWidth(radius)),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isDrawer
              ? GestureDetector(
                  onTap: onPress,
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/menu_dots.svg',
                      width: 35,
                      height: 40,
                    ),
                  ),
                )
              : Text(''),
          Text(
            screenName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          back
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ))
              : Text("   "),
        ],
      ),
    );
  }
}
