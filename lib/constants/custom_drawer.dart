import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import '../screens/about_us.dart';
import '../user/settings.dart';
import '../user/orders_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/sign_choice.dart';
import '../size_config.dart';
import '../user/cart.dart';
import '../user/home_screen.dart';
import '../user/profile.dart';
import '../user/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  final bool isSelected;
  final String userName;
  final String mobileNumber;
  const CustomDrawer({
    Key key,
    this.isSelected,
    this.userName,
    this.mobileNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       ClipOval(
            //         child: Image.asset(
            //           'assets/images/person.png',
            //           height: 70,
            //           width: 70,
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Text(
            //             tr('user_name'),
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 16),
            //           ),
            //           Text('01156631969'),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Divider(),
            DrawerItem(
              icon: 'assets/icons/homeIcon.svg',
              text: tr("home"),
              isSelected: true,
              topMargin: 40,
              press: () =>
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName),
            ),
            DrawerItem(
              isSelected: false,
              press: () =>
                  Navigator.pushReplacementNamed(context, Cart.routeName),
              icon: 'assets/icons/Cart red.svg',
              text: tr("cart"),
            ),
            DrawerItem(
              isSelected: false,
              press: () =>
                  Navigator.pushReplacementNamed(context, Profile.routeName),
              icon: 'assets/icons/user.svg',
              text: tr("profile"),
            ),
            DrawerrItem(
              onpress: () => Navigator.pushReplacementNamed(
                  context, OrderScreen.routeName),
              title: tr("orders"),
              icon: Container(
                width: getProportionateScreenWidth(32),
                height: getProportionateScreenHeight(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.box,
                  color: Colors.grey[700],
                ),
              ),
            ),
            DrawerItem(
              isSelected: false,
              press: () {
                Navigator.pushReplacementNamed(
                  context,
                  Settings.routeName,
                );
              },
              icon: 'assets/icons/settings.svg',
              text: tr("settings"),
            ),
            DrawerItem(
              isSelected: false,
              press: () {
                Navigator.pushReplacementNamed(context, Reviews.routeName);
              },
              icon: 'assets/icons/menuBar.svg',
              text: tr("reviews"),
            ),
            DrawerrItem(
              onpress: () =>
                  Navigator.pushReplacementNamed(context, AboutUs.routeName),
              title: tr("about_us"),
              icon: Container(
                  width: getProportionateScreenWidth(32),
                  height: getProportionateScreenHeight(32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.grey[700],
                    ),
                  ),
                  child: Center(
                      child: FaIcon(
                    FontAwesomeIcons.info,
                    color: Colors.grey[700],
                    size: 18,
                  ))),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                DialogBuilder(context).showLoadingIndicator();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                Future.delayed(Duration(seconds: 2)).then((value) => {
                      prefs.remove("password"),
                      DialogBuilder(context).hideOpenDialog(),
                      Navigator.pushReplacementNamed(
                          context, SignChoice.routeName),
                    });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFFFEC40D),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      tr("logout"),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Image.asset('assets/icons/Group 12524.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(50)),
          ],
        ),
      ),
    );
  }
}

class DrawerrItem extends StatelessWidget {
  final Widget icon;
  final Function onpress;
  final String title;
  const DrawerrItem({
    this.onpress,
    this.icon,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.only(left: 70, top: 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Row(
          children: [
            icon,
            SizedBox(width: 22),
            Text(
              title,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text, icon;
  final double topMargin;
  final bool isSelected;
  final Function press;

  DrawerItem({
    @required this.icon,
    @required this.isSelected,
    @required this.text,
    this.topMargin = 0,
    @required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 70, top: topMargin),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: isSelected
            ? BoxDecoration(
                color: Color(0xFFFEC40D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
              )
            : null,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: getProportionateScreenWidth(50),
              height: getProportionateScreenHeight(50),
              color: isSelected ? Colors.red[800] : Colors.grey[700],
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
