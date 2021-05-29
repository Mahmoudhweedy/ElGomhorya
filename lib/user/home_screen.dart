import '../constants/ads_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/my_btn_nav_bar.dart';
import '../constants/categoriesItem.dart';
import '../constants/custom_drawer.dart';
import '../constants/home_slider.dart';
import '../constants/my_app_bar.dart';
import '../models/stores.dart';
import '../services/services.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
import 'categories_screen.dart';
import 'latest_offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String routeName = '/home_user';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url;
  YoutubePlayerController _controller;


@override
  void didChangeDependencies() async{
    url = await Services().getAdVideos();
    print(' from did change $url');
    runYouTubePlayer();
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void runYouTubePlayer() async {
    print('youtube $url');
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          url),
      flags: const YoutubePlayerFlags(
        hideControls: true,
        hideThumbnail: true,
      ),
    )..addListener(listener);
  }

  void listener() {}

  final keyIsFirstLoaded = 'is_first_loaded';

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 1), () => buildAdVideo());
    print('youtube $url');
    print(url);
    Future.delayed(
        Duration(seconds: 2), () => showDialogIfFirstLoaded(context));

    SizeConfig().init(context);
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: CustomDrawer(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: FutureBuilder(
        future: Services().getStores(),
        builder: (BuildContext context, AsyncSnapshot<List<Stores>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: RefreshProgressIndicator(
                backgroundColor: Color(0xFFFEC40D),
              ),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: RefreshProgressIndicator(
                backgroundColor: Color(0xFFFEC40D),
              ),
            );
          }
           List  stores = snapshot.data;
           stores.insert(4, Stores());
           stores.insert(9, Stores());
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyAppBar(
                  back: false,
                  onPress: () {
                    widget._scaffoldKey.currentState.openDrawer();
                  },
                  radius: 0,
                  screenName: tr('home').toUpperCase(),
                ),
                HomeSlider(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10),
                      vertical: getProportionateScreenHeight(15)),
                  // height: getProportionateScreenHeight(70),
                  width: SizeConfig.screenWidth,
                  color: Color(0xFF333333),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/fi-rr-database.svg',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      Text(
                        '    ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        tr("gomhorya_stores"),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/white_logo.png',
                        width: getProportionateScreenWidth(35),
                        height: getProportionateScreenHeight(35),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.start,
                   
                    children: List.generate(snapshot.data.length, (index) {
                      if (index == 4) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LatestOffer()));
                          },
                          child: Header(
                            leadingIcon: 'assets/icons/tag.svg',
                            title: tr("latest_offers"),
                            postfixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                    width: getProportionateScreenWidth(30)),
                                Text(
                                  tr("here"),
                                  style: TextStyle(
                                    color: Color(0xFFFEC40D),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(20)),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 30,
                                  color: Color(0xFFFEC40D),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      if (index == 9) {
                        return ADSBar();
                      }
                      return CategoriesItem(
                        navigateTo: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            print(
                                'len ${stores[index].categories.length}');

                            return CategoriesScreen(
                              categories: stores[index].categories,
                            );
                          }));
                        },
                        categoryName: stores[index].companyName ?? "محل",
                        picture: SvgPicture.asset(
                          'assets/icons/Store Red.svg',
                          width: getProportionateScreenWidth(80),
                          height: getProportionateScreenHeight(80),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          );
        },
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              height: 300,
              width: 250,
              color: Color(0xFF333333),
              child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    onEnded: (metaData) => Navigator.pop(context),
                    controller: _controller,
                    aspectRatio: 1.15,
                  ),
                  builder: (context, player) {
                    return Column(
                      children: [
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                              prefs.setBool(keyIsFirstLoaded, false);
                            }),
                        player,
                      ],
                    );
                  }),
            ),
          );
        },
      );
    }
  }
}

class Header extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final Widget postfixIcon;
  const Header({
    Key key,
    @required this.leadingIcon,
    @required this.title,
    @required this.postfixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      height: getProportionateScreenHeight(70),
      width: SizeConfig.screenWidth,
      color: Color(0xFF333333),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            child: Row(
              children: [
                SizedBox(
                    child: SvgPicture.asset(
                  leadingIcon,
                  width: 20,
                  height: 20,
                  color: Colors.white,
                )),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          postfixIcon,
        ],
      ),
    );
  }
}
