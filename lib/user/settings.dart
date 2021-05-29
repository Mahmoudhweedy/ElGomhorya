import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/custom_drawer.dart';
import 'package:elgomhorya/constants/my_app_bar.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import 'package:elgomhorya/models/social.dart';
import 'package:elgomhorya/screens/sign_choice.dart';
import 'package:elgomhorya/user/saved_Location.dart';
import 'package:elgomhorya/screens/terms.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:elgomhorya/user/lang_country.dart';
import 'package:elgomhorya/user/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'balance.dart';

class Settings extends StatelessWidget {
  static String routeName = '/settings';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
                radius: 30,
                screenName: tr("settings"),
                onPress: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Circles(
                  onPress: () =>
                      Navigator.pushNamed(context, OrderScreen.routeName),
                  image: 'assets/icons/truck.svg',
                  text: tr("orders"),
                ),
                Circles(
                  image: 'assets/icons/wallet.svg',
                  text: tr("balance"),
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Balance(),
                        ));
                  },
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),
            SettingsOption(
              image: 'assets/icons/home.svg',
              label: tr('saved_locations'),
              onPress: () => Navigator.pushNamed(context, SavedLocations.routeName),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),
            SettingsOption(
              image: 'assets/icons/translate.svg',
              label: tr('language_country'),
              onPress: () =>
                  Navigator.pushNamed(context, LanguageAndCountries.routeName),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),
            SettingsOption(
              image: 'assets/icons/term.svg',
              label: tr('terms'),
              onPress: () => Navigator.pushNamed(context, Terms.routeName),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: FutureBuilder(
                          future: Services().getSocial(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Social>> snapshot) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _launchURL(snapshot.data[0].website);
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.globe,
                                          color: Color(0xFF333333),
                                          size: 80,
                                        ),
                                      ),
                                      SocialMediaIcon(
                                        icon: FontAwesomeIcons.youtube,
                                        iconSize: 60,
                                        color: Colors.red,
                                        onPress: () {
                                          _launchURL(snapshot.data[0].youTube);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SocialMediaIcon(
                                        iconSize: 60,
                                        color: Colors.blueAccent,
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
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )),
                                          child: FaIcon(
                                            FontAwesomeIcons.facebookF,
                                            color: Colors.blue,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300], width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    tr("contact_us"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    Key key,
    @required this.image,
    @required this.label,
    @required this.onPress,
  }) : super(key: key);
  final String image;
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            onPressed: onPress,
          ),
        ],
      ),
    );
  }
}

class Circles extends StatelessWidget {
  const Circles({
    Key key,
    this.image,
    this.text,
    this.onPress,
  }) : super(key: key);
  final String image, text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
                border: Border.all(
                  color: kPrimaryColor,
                )),
            child: SvgPicture.asset(
              image,
              width: 90,
              height: 90,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
