import 'package:elgomhorya/user/settings.dart';

import '../user/cart.dart';
import '../user/home_screen.dart';
import '../user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 2),
          blurRadius: 5,
          spreadRadius: 5,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              setBottomBarIndex(0);
            },
            child: SvgPicture.asset(
              'assets/icons/homeIcon.svg',
              width: getProportionateScreenWidth(70),
              height: getProportionateScreenHeight(70),
              color: currentIndex == 0 ? Color(0xFFB51F32) : Colors.grey[800],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Cart.routeName);
              setBottomBarIndex(1);
            },
            child: SizedBox(
              child: SvgPicture.asset(
                'assets/icons/Cart red.svg',
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenHeight(70),
                color: currentIndex == 1 ? Colors.red : Colors.grey[600],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, Profile.routeName);
              setBottomBarIndex(2);
            },
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              width: getProportionateScreenWidth(70),
              height: getProportionateScreenHeight(70),
              color: currentIndex == 2 ? Colors.red : Colors.grey[600],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context,
                   Settings.routeName,
                  );
            },
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: getProportionateScreenWidth(70),
              height: getProportionateScreenHeight(70),
              color: currentIndex == 3 ? Colors.red : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
