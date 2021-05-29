import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import '../constants/categoriesItem.dart';
import '../constants/custom_drawer.dart';
import '../constants/home_slider.dart';
import '../constants/my_app_bar.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'products_screen.dart';
import '../constants/constants.dart';

class CategoriesScreen extends StatefulWidget {
  final List categories;

  static String routeName = '/categories_user';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategoriesScreen({Key key, this.categories}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String icons = 'assets/icons/';

  final String imageUrl = '${image}category/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyAppBar(
                  onPress: () {
                    widget._scaffoldKey.currentState.openDrawer();
                  },
                  radius: 0,
                  screenName: tr('categories'),
                ),
                HomeSlider(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15)),
                  height: getProportionateScreenHeight(70),
                  color: Color(0xFF333333),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: SvgPicture.asset(
                        'assets/icons/fi-rr-database.svg',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      )),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      Text(
                        tr("browse_categories"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  children: List.generate(widget.categories.length, (index) {
                    if (index == 4) {
                      return Container(
                        height: getProportionateScreenHeight(100),
                        color: Colors.black87,
                        child: Center(
                          child: Text(
                            "ADS",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return CategoriesItem(
                      navigateTo: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ProductsScreen(
                            productsJson: widget.categories[index]['Products'],
                          );
                        }));
                      },
                      categoryName: widget.categories[index]['name'],
                      picture: Image.network(
                        "$imageUrl${widget.categories[index]["image"]}",
                        width: getProportionateScreenWidth(140),
                        height: getProportionateScreenHeight(100),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: MyBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
