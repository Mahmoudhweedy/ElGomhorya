import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/dialogue.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../constants/custom_drawer.dart';
import '../constants/my_app_bar.dart';
import '../models/cart.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'orders_screen.dart';

class Cart extends StatefulWidget {
  static String routeName = '/cart';
  final int quantity;

  const Cart({Key key, this.quantity = 0}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final String imageUrl = '${image}products/';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _productQuantity = 0;
  // int _totalCost = 0;
  int productPrice = 200;

  void _increment() {
    setState(() {
      _productQuantity++;
    });
    // _totalCostCount();
  }

  void _decrement() {
    if (_productQuantity > 0) {
      setState(() {
        _productQuantity--;
      });
      // _totalCostCount();
    }
  }

  String mobile;
  String fName;
  String lName;
  int totalQuantity = 0;

  @override
  void didChangeDependencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getString("mobile");
    fName = prefs.getString("f_name");
    lName = prefs.getString("l_name");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(fName);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: FutureBuilder(
          future: Services().getCartData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                height: SizeConfig.screenHeight * .64,
                child: Center(
                  child: SpinKitCubeGrid(color: Color(0xFFFEC40D)),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                // height: SizeConfig.screenHeight - 70,
                child: Column(
                  children: [
                    MyAppBar(
                        onPress: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        radius: 20,
                        screenName: tr("cart")),
                    SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Image.asset('assets/images/cartEmpty.png'),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "سلتك فارغة",
                      style: TextStyle(fontSize: 30, color: Color(0xFFFEC40D)),
                    ),
                  ],
                ),
              );
            }

            Provider.of<CartData>(context, listen: false)
                .setInitItems(snapshot.data[0]);
            print(" kkk ${Provider.of<CartData>(context).cartItems[0].type}");
            print('dsdfsdf ${snapshot.data[1].runtimeType}');
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyAppBar(
                      onPress: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      radius: 20,
                      screenName: tr("cart")),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Row(
                      children: [
                        Text(
                          tr('total_cost'),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(' ${snapshot.data[1]} ${tr("egp")}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/Cart red.svg',
                          width: getProportionateScreenWidth(50),
                          height: getProportionateScreenHeight(80),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * .5,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(220)),
                      itemCount:
                          Provider.of<CartData>(context).cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (Provider.of<CartData>(context).cartItems.isEmpty) {
                          return Container(
                            height: SizeConfig.screenHeight * .64,
                            child: Center(
                              child: Image.asset('assets/images/cartEmpty.png'),
                            ),
                          );
                        }
                        final product =
                            Provider.of<CartData>(context).cartItems[index];
                        List products =
                            Provider.of<CartData>(context).cartItems;

                        products.forEach((element) {
                          int quantity = int.parse(element.quantity);

                          totalQuantity = totalQuantity + quantity;
                          return totalQuantity.toString();
                        });
                        _productQuantity = totalQuantity;
                        print(
                            " priceyyy ${Provider.of<CartData>(context).cartItems[index].price} ");
                        return Dismissible(
                          background: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
                            child: Center(
                                child: Container(
                              color: Colors.red,
                              height: getProportionateScreenHeight(100),
                            )),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              DialogBuilder(context).showLoadingIndicator();
                              Provider.of<CartData>(context, listen: false)
                                  .removeProduct(product);

                              DialogBuilder(context).hideOpenDialog();
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("تم ازالة المنتج")));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(100),
                                  width: 5,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 30),
                                  width: getProportionateScreenWidth(90),
                                  height: getProportionateScreenHeight(90),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                          color: Colors.black12,
                                          offset: Offset(0, 2),
                                        ),
                                      ]),
                                  child: Image.network(
                                    '$imageUrl${Provider.of<CartData>(context).cartItems[index].productImage ?? '7_image.jpg'}',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${Provider.of<CartData>(context).cartItems[index].productName}" ??
                                          "name",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                        ' ${Provider.of<CartData>(context).cartItems[index].price} ${tr("egp")}',
                                        textAlign: TextAlign.center),
                                    Text(
                                        Provider.of<CartData>(context)
                                                .cartItems[index]
                                                .type ??
                                            "قطعة",
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                SizedBox(width: 30),
                                CountBar(
                                  product: Provider.of<CartData>(context)
                                      .cartItems[index],
                                  quantity: int.parse(product.quantity),
                                  decrement: () async {
                                    int price = double.parse(
                                            Provider.of<CartData>(context,
                                                    listen: false)
                                                .cartItems[index]
                                                .price)
                                        .toInt();
                                    DialogBuilder(context)
                                        .showLoadingIndicator();
                                    await Services().cartItemDecrement(
                                        cartId: product.id,
                                        price:
                                            "${price * int.parse(product.quantity)}");
                                    _decrement();
                                    DialogBuilder(context).hideOpenDialog();
                                  },
                                  increment: () async {
                                    int price = double.parse(
                                            Provider.of<CartData>(context,
                                                    listen: false)
                                                .cartItems[index]
                                                .price)
                                        .toInt();
                                    DialogBuilder(context)
                                        .showLoadingIndicator();
                                    await Services().cartItemIncrement(
                                        cartId: product.id,
                                        price:
                                            "${price * int.parse(product.quantity)}");

                                    _increment();
                                    DialogBuilder(context).hideOpenDialog();
                                  },
                                ),
                                Container(width: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ConfirmDialog(
                    fName: fName,
                    lName: lName,
                    mobile: mobile,
                    productQuantity: snapshot.data[2],
                    totalPrice: snapshot.data[1],
                  )
                ],
              ),
            );
          }),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final int productQuantity;
  final int totalPrice;
  final String fName, lName, mobile;

  const ConfirmDialog({
    Key key,
    this.productQuantity,
    this.totalPrice,
    this.fName,
    this.lName,
    this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('الفاتورة'),
                content: Container(
                  height: getProportionateScreenHeight(100),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('عدد المنتجات'),
                          Text('$productQuantity'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('اجمالي التكلفة'),
                          Text(' $totalPrice ${tr("egp")}'),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  AlertButton(
                    text: 'تأكيد',
                    onPress: () async {
                      DialogBuilder(context).showLoadingIndicator();
                      await Services().addToOrders(
                        productPrice: totalPrice.toString(),
                        productQuantity: productQuantity.toString(),
                      );
                      DialogBuilder(context).hideOpenDialog();
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => OrderScreen()));
                    },
                  ),
                  AlertButton(
                    text: 'إلغاء',
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        width: SizeConfig.screenWidth,
        height: getProportionateScreenHeight(80),
        decoration: BoxDecoration(
          color: Color(0xFFFEC40D),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'تأكيد الطلبات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  final String text;
  final Function onPress;
  const AlertButton({
    this.text,
    this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          color: Color(0xFFFEC40D),
          width: 60,
          height: 60,
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white),
          )),
        ));
  }
}

class CountBar extends StatelessWidget {
  final CartProducts product;
  final int quantity;
  final Function increment;
  final Function decrement;
  const CountBar({
    @required this.product,
    @required this.quantity,
    @required this.increment,
    @required this.decrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: decrement,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "-",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          width: getProportionateScreenWidth(50),
          height: getProportionateScreenHeight(50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1.5,
                color: Colors.grey,
              )),
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Center(
            child: Text(
              "$quantity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: increment,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
