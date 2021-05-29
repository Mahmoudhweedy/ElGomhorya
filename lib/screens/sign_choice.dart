import 'package:easy_localization/easy_localization.dart';
import '../models/social.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/logo_container.dart';
import '../constants/welcome_button.dart';
import '../store/create_account_screen.dart';
import '../size_config.dart';
import '../screens/forget_password.dart';
import '../user/complete_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';

class SignChoice extends StatelessWidget {
  static String routeName = '/sign_choice';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: SizeConfig.screenHeight * .45,
              color: Color(0xFFFEC40D),
              child: Center(
                  child: LogoContainer(
                pictureAsset: 'assets/images/white_logo.png',
              )),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CompleteRegister.routeName);
                    },
                    child: Container(
                      color: Color(0xFFFEC40D),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/man.svg',
                            color: Color(0xFF333333),
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            tr("user_account"),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, CreateStoreAccount.routeName);
                      },
                      child: Container(
                        color: Color(0xFFB51F32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/store.svg',
                              width: getProportionateScreenWidth(30),
                              height: getProportionateScreenHeight(30),
                              color: Colors.white,
                            ),
                            Text(
                              tr("store_account"),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(25)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: WelcomeButton(
                textColor: Colors.white,
                title: tr("login_button"),
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                decoration: BoxDecoration(
                    color: Color(0xFF3f3f47),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgetPassword.routeName),
              child: Text(
                tr("forget_password"),
                style: TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Spacer(),
            FutureBuilder(
              future: Services().getSocial(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Social>> snapshot) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(9, 0),
                          spreadRadius: 4,
                          blurRadius: 6,
                          color: Colors.black38),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          _launchURL(snapshot.data[0].website);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.globe,
                          color: Color(0xFF333333),
                          size: 45,
                        ),
                      ),
                      SocialMediaIcon(
                        icon: FontAwesomeIcons.youtube,
                        onPress: () {
                          _launchURL(snapshot.data[0].youTube);
                        },
                      ),
                      SocialMediaIcon(
                        icon: FontAwesomeIcons.twitter,
                        onPress: () {
                          _launchURL(snapshot.data[0].twitter);
                        },
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL(snapshot.data[0].fb);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF333333),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}

class SocialMediaIcon extends StatelessWidget {
   SocialMediaIcon({
    Key key,
    @required this.icon,
    @required this.onPress,
    this.color= Colors.black, this.iconSize = 30,
  }) : super(key: key);
  final IconData icon;
  final Function onPress;
  final Color color ;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: FaIcon(
          icon,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
