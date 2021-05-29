import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/welcome_button.dart';
import '../user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../size_config.dart';

class Congrats extends StatelessWidget {
  static String routeName = '/congrats';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: SizeConfig.screenWidth, height: SizeConfig.screenHeight),
            Container(
              padding: EdgeInsets.only(
                right: getProportionateScreenWidth(20),
                left: getProportionateScreenWidth(20),
                bottom: 10,
              ),
              width: double.infinity,
              // height: SizeConfig.screenHeight * .43,
              decoration: BoxDecoration(
                color: Color(0xFFFEC40D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SvgPicture.asset(
                      'assets/icons/Approved.svg',
                      width: getProportionateScreenWidth(200),
                      height: getProportionateScreenHeight(200),
                    ),
                  ),
                  Text(
                    tr('congrats'),
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.red[800]),
                  ),
                  Text(
                    tr('account_verified'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Money.svg',
                      width: getProportionateScreenWidth(200),
                      height: getProportionateScreenHeight(200),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                      child: Text(tr("you_can_manage")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: WelcomeButton(
                        onPress: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (!prefs.containsKey("type")) {
                            _launchURL("https://dashboard.elgmhoria.com/");
                          }
                          else{
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
                        textColor: Colors.white,
                        decoration: BoxDecoration(
                            color: Color(0xFFFEC40D),
                            borderRadius: BorderRadius.circular(50)),
                        title: tr('goto_home'),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      tr('new_success_partner'),
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      tr('in_ecommerce_future'),
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(50)),
                  ],
                ),
              ),
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
