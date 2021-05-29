import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/models/reviews.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/custom_drawer.dart';
import '../constants/my_app_bar.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  static String routeName = '/reviews';

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  double rate;
  TextEditingController _controller = TextEditingController();
  String fName;
  String lName;
  @override
  void didChangeDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fName = prefs.getString("f_name");
    lName = prefs.getString("l_name");
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(fName);
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyAppBar(
                radius: 20,
                screenName: tr("product_reviews"),
                onPress: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
            SizedBox(height: getProportionateScreenHeight(30)),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tr("add_review"),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Container(
                                padding: EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: kPrimaryColor,
                                    )),
                                child: Text(
                                  tr("profile_picture"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                glow: false,
                                itemSize: 30,
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  rate = rating;
                                  print(rating);
                                },
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: _controller,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: tr("add_comment"),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  DialogBuilder(context).showLoadingIndicator();
                                  await Services().addReview(
                                    number: rate.toString(),
                                    comment: _controller.text,
                                  );
                                  DialogBuilder(context).hideOpenDialog();
                                  print('${_controller.text} $rate');
                                  _controller.clear();
                                  Navigator.pop(context);
                                  await Services().getReviews();
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 50,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    tr("add"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tr("add_review"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: Services().getReviews(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Review>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: SpinKitCubeGrid(
                      color: kPrimaryColor,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitCubeGrid(
                      color: kPrimaryColor,
                    ),
                  );
                }
               
                return Column(
                    children: List.generate(snapshot.data.length, (index) {
                       print(snapshot.data[index].fName);
                  return Container(
                    height: getProportionateScreenHeight(200),
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/person.png',
                                height: 70,
                                width: 70,
                              ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                            Text(
                              '${snapshot.data[index].fName} ${snapshot.data[index].lName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(width: 15),
                            RatingBar.builder(
                              maxRating: snapshot.data[index].rate.toDouble(),
                              updateOnDrag: true,
                              glow: false,
                              itemSize: 20,
                              initialRating:
                                  snapshot.data[index].rate.toDouble(),
                              minRating: snapshot.data[index].rate.toDouble(),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                        Divider(thickness: 3),
                        Text(
                          snapshot.data[index].comment,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
