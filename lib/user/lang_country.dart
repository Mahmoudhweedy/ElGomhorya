import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/constants.dart';
import '../constants/custom_drawer.dart';
import '../constants/my_app_bar.dart';
import '../constants/my_btn_nav_bar.dart';
import '../constants/welcome_button.dart';
import 'package:flutter/material.dart';

class LanguageAndCountries extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  static String routeName = '/countries';
  static List<Map> countries = [
    {
      'flag': 'assets/images/egypt.png',
      'name': tr("egypt"),
    },
    {
      'flag': 'assets/images/ksa.png',
      'name': tr("ksa"),
    },
    {
      'flag': 'assets/images/UAE.png',
      'name': tr("uae"),
    },
    {
      'flag': 'assets/images/Qatar.png',
      'name': tr("qatar"),
    },
    {
      'flag': 'assets/images/oman.png',
      'name': tr("oman"),
    },
    {
      'flag': 'assets/images/Kuwait.png',
      'name': tr("kuwait"),
    },
    {
      'flag': 'assets/images/bahrain.png',
      'name': tr("bahrain"),
    },
    {
      'flag': 'assets/images/globe.png',
      'name': tr('rest_of_world'),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              radius: 30,
              screenName: tr('language_country'),
              onPress: () => _key.currentState.openDrawer(),
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Text(
                tr("language_choose"),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await context.setLocale(Locale('ar', 'EG'));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 5,
                    ),
                    child: Text(
                      'العربية',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await context.setLocale(Locale('en', 'US'));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 5,
                    ),
                    child: Text(
                      'English',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Text(
                tr("country_choose"),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  countries.length,
                  (index) => Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[200],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            countries[index]['flag'] !=
                                    'assets/images/globe.png'
                                ? Image.asset(
                                    countries[index]['flag'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.contain,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.globe,
                                    size: 45,
                                  ),
                            SizedBox(width: 15),
                            Text(
                              countries[index]['name'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
              child: WelcomeButton(
                onPress: () {},
                textColor: Colors.white,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                title: tr("apply"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
