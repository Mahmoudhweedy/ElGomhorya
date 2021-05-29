import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/constants.dart';
import 'package:elgomhorya/constants/custom_drawer.dart';
import 'package:elgomhorya/constants/my_app_bar.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import 'package:elgomhorya/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
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
              screenName: tr('balance'),
              onPress: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: Services().getPoints(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Text("");
                }
                return Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              '${tr("current_balance")} :',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${snapshot.data ?? 0} ${tr("egp")}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Center(
                                        child: Text(tr("add_gift_card"))),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[200],
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: tr("add_gift_cart_here"),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 45, vertical: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey[200],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            tr("cancel"),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 45, vertical: 10),
                                        color: kSecondryColor,
                                        child: Text(
                                          tr("add"),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: kSecondryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${tr("add_gift_card")}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
