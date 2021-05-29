import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/custom_drawer.dart';
import 'package:elgomhorya/constants/my_app_bar.dart';
import 'package:elgomhorya/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {
  static String routeName = '/about';
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
                screenName: tr("about_us"),
                onPress: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: kMyBlack,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/map.svg',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '24 شارع عامر - الدقي - الجيزة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'info@elgmhoria.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/call.svg',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '+2 123456789',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: .9,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                  6,
                  (index) => AboutUsItem(
                        index: index,
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class AboutUsItem extends StatelessWidget {
  final int index;
  static const List<String> icons = [
    'assets/icons/gift.svg',
    'assets/icons/product.svg',
    'assets/icons/delivery.svg',
    'assets/icons/return-box.svg',
    'assets/icons/credit-card.svg',
    'assets/icons/shopping-bag.svg',
  ];

  const AboutUsItem({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            icons[index],
            height: 80,
            width: 80,
            color: kPrimaryColor,
          ),
          Text(
            tr("product$index"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            tr("aboutus${index + 1}"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
