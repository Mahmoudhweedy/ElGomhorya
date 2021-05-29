import 'package:easy_localization/easy_localization.dart';
import '../constants/my_app_bar.dart';
import '../models/orders.dart';
import '../services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/custom_drawer.dart';
import '../size_config.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = '/orders';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();
  String mobile;
  String location;

  @override
  void didChangeDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getString("mobile");
    location = prefs.getString("address");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('mobile $mobile');
    print('$location');
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              onPress: () {
                _scaffoldKey.currentState.openDrawer();
              },
              radius: 20,
              screenName: tr("orders"),
            ),
            FutureBuilder(
              future: Services().getOrdersData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Orders> orders = snapshot.data[0];

                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      int step = orders[index].orderStatus == "new"
                          ? 1
                          : orders[index].orderStatus == "ready"
                              ? orders[index].orderDeliverd == "new"
                                  ? orders[index].orderStatus == "new"
                                      ? 1
                                      : 3
                                  : orders[index].orderDeliverd == "delivered"
                                      ? 4
                                      : 2
                              : 1;
                      int totalPrice =
                          int.parse(orders[index].productQuantity) *
                              int.parse(orders[index].productPrice);

                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              color: Color(0xFFFEC40D),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    tr("order_name"),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "   ${orders[index].fName} ${orders[index].lName}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => print('Tapped:0'),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: step != 1
                                                    ? Colors.grey
                                                    : Color(0xFFFEC40D),
                                                width: 3.0,
                                              ),
                                              color: step == 1
                                                  ? Color(0xFFFEC40D)
                                                  : Colors.grey,
                                            ),
                                            child: Container(
                                              child: Image.asset(
                                                step == 1
                                                    ? "assets/icons/new.png"
                                                    : "assets/icons/new.png",
                                                color: step == 1
                                                    ? Colors.white
                                                    : Color(0xFF333333),
                                                width: 40,
                                                height: 40,
                                              ),
                                           
                                            ),
                                          ),
                                          Text(
                                            tr("new_order"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: step == 1
                                                  ? Color(0xFFFEC40D)
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => print('Tapped:0'),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: step != 2
                                                    ? Colors.grey
                                                    : Color(0xFFFEC40D),
                                                width: 3.0,
                                              ),
                                              color: step == 2
                                                  ? Color(0xFFFEC40D)
                                                  : Colors.grey,
                                            ),
                                            child: Container(
                                              child: Image.asset(
                                                step == 2
                                                    ? "assets/icons/review.png"
                                                    : "assets/icons/review.png",
                                                color: step == 2
                                                    ? Colors.white
                                                    : Color(0xFF333333),
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            tr("in_prep_state"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: step == 2
                                                  ? Color(0xFFFEC40D)
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => print('Tapped:0'),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: step != 3
                                                    ? Colors.grey
                                                    : Color(0xFFFEC40D),
                                                width: 3.0,
                                              ),
                                              color: step == 3
                                                  ? Color(0xFFFEC40D)
                                                  : Colors.grey,
                                            ),
                                            child: Container(
                                              child: Image.asset(
                                                step == 3
                                                    ? "assets/icons/manage.png"
                                                    : "assets/icons/manage.png",
                                                color: step == 3
                                                    ? Colors.white
                                                    : Color(0xFF333333),
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            tr("prep"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: step == 3
                                                  ? Color(0xFFFEC40D)
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => print('Tapped:0'),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: step != 4
                                                    ? Colors.grey
                                                    : Color(0xFFFEC40D),
                                                width: 3.0,
                                              ),
                                              color: step == 4
                                                  ? Color(0xFFFEC40D)
                                                  : Colors.grey,
                                            ),
                                            child: Container(
                                              child: SvgPicture.asset(
                                                step == 4
                                                    ? "assets/icons/delivered.svg"
                                                    : "assets/icons/delivered.svg",
                                                color: step == 4
                                                    ? Colors.white
                                                    : Color(0xFF333333),
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            tr("order_delivered"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: step == 4
                                                  ? Color(0xFFFEC40D)
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(18),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    " ${tr('address')} : ",
                                    style: TextStyle(
                                      color: Color(0xFFFEC40D),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: SizeConfig.screenWidth * .685,
                                        child: Text(
                                          location ?? tr("location"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Icon(Icons.pin_drop_outlined),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    tr("quantity"),
                                    style: TextStyle(
                                      color: Color(0xFFFEC40D),
                                    ),
                                  ),
                                  Text(
                                    " : ${orders[index].productQuantity.toString()}",
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    tr("total_price"),
                                    style: TextStyle(
                                      color: Color(0xFFFEC40D),
                                    ),
                                  ),
                                  Text(
                                    ' : $totalPrice',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
