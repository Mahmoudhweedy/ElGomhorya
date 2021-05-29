import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../models/products.dart';
import '../user/product_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/constants.dart';
import '../models/offer.dart';
import '../services/services.dart';
import 'package:flutter/cupertino.dart';
import '../constants/custom_drawer.dart';
import '../constants/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

final String imageUrl = '${image}products/';

class LatestOffer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String routeName = '/latest_offer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: Services().getLatestOffers(),
        builder: (BuildContext context, AsyncSnapshot<LatestOffers> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: RefreshProgressIndicator(
                    backgroundColor: Color(0xFFFEC40D)));
          }
          if (snapshot.data == null) {
            return Column(
              children: [
                MyAppBar(
                  onPress: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  radius: 0,
                  screenName: tr('latest_offers').toUpperCase(),
                ),
                Center(child: Text('لا يوجد عروض حالياً'))
              ],
            );
          }
          return Stack(
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
                        _scaffoldKey.currentState.openDrawer();
                      },
                      radius: 0,
                      screenName: tr('latest_offers').toUpperCase(),
                    ),
                    OffersHeader(
                      title: tr('one_day_offer'),
                    ),
                    OfferSlider(
                      offers: snapshot.data.dailyOffers,
                    ),
                    OffersHeader(title: tr('week_offer')),
                    OfferSlider(
                      offers: snapshot.data.weeklyOffers,
                    ),
                    OffersHeader(title: tr('month_offers')),
                    OfferSlider(offers: snapshot.data.monthlyOffers),
                    SizedBox(height: 70),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: MyBottomNavigationBar(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OfferSlider extends StatelessWidget {
  final List offers;

  const OfferSlider({
    @required this.offers,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          offers.length,
          (index) {
            int price;
            int offer;
            Product product;

            price = int.parse(offers[index]['products'][0]['price']);
            offer = offers[index]['products'][0]['offer'];
            product = Product(
              name: offers[index]['products'][0]['name'],
              price: offers[index]['products'][0]['price'],
              offer: offers[index]['products'][0]['offer'].toString(),
              image: offers[index]['products'][0]['image'],
              id: offers[index]['products'][0]['id'],
              quantity: offers[index]['products'][0]['quantity'].toString(),
              extraQuantity: offers[index]['products'][0]['extraQuantity'],
            );

            int priceAfterOffer = price - (price * (offer / 100)).toInt();

            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5),
                  vertical: getProportionateScreenHeight(5)),
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(12),
                  vertical: getProportionateScreenHeight(15)),
              width: getProportionateScreenWidth(155),
              // height: getProportionateScreenHeight(420),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(20)),
                  border: Border.all(width: 1)),
              child: Column(
                children: [
                  Image.network(
                    '$imageUrl${product.image}',
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenHeight(100),
                    fit: BoxFit.fill,
                  ),
                  Text(product.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Counter(text: tr("m_counter")),
                      Counter(text: tr("h_counter")),
                      Counter(text: tr("d_counter")),
                      Counter(text: tr("w_counter")),
                    ],
                  ),
                  Text(
                    tr('elmansy_stores'),
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${tr("retail_discount")} : $offer% ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red[800],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            ' $priceAfterOffer ${tr("pound")}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red[800],
                            ),
                          ),
                          Text(
                            ' $price ${tr("pound")}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${tr("wholesale_discount")} : $offer% ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red[800],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            ' $priceAfterOffer ${tr("pound")}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red[800],
                            ),
                          ),
                          Text(
                            ' $price ${tr("pound")}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(''),
                  GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        isDismissible: false,
                        bounce: true,
                        context: context,
                        builder: (context) => ModalBottomSheetClass(
                          offerPrice: priceAfterOffer,
                          product: product,
                        ),
                      );
                    },
                    child: Container(
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenHeight(45),
                      margin: EdgeInsets.fromLTRB(
                        getProportionateScreenWidth(10),
                        0,
                        getProportionateScreenWidth(10),
                        0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFFEC40D),
                      ),
                      child: Center(
                        child: Text(
                          tr('add_to_cart'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//         child: Row(
//             children: List.generate(
//       offers.length,
//       (index) {
// int price = int.parse(offers[0]['products'][index]['price']);
// int offer = offers[0]['products'][index]['offer'];
// int priceAfterOffer = price - (price * (offer / 100)).toInt();
// Product product = Product(
//   name: offers[0]['products'][index]['name'],
//   price: offers[0]['products'][index]['price'],
//   offer: offers[0]['products'][index]['offer'].toString(),
//   image: offers[0]['products'][index]['image'],
//   id: offers[0]['products'][index]['id'],
//   quantity: offers[0]['products'][index]['quantity'].toString(),
//   extraQuantity: offers[0]['products'][index]['extraQuantity'],
// );
//         return Container(
//           width: 150,
//           height: 150,
//           margin: EdgeInsets.symmetric(horizontal: 30),
//           color: Colors.grey,
//         );
/*  Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5),
              vertical: getProportionateScreenHeight(5)),
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateScreenHeight(15)),
          width: getProportionateScreenWidth(155),
          // height: getProportionateScreenHeight(420),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenHeight(20)),
              border: Border.all(width: 1)),
          child: Column(
            children: [
              Image.network(
                '$imageUrl${product.image}',
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(100),
                fit: BoxFit.fill,
              ),
              Text(product.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Counter(),
                  Counter(),
                  Counter(),
                  Counter(),
                ],
              ),
              Text(
                tr('elmansy_stores'),
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${tr("retail_discount")} : $offer% ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red[800],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        ' $priceAfterOffer ${tr("pound")}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red[800],
                        ),
                      ),
                      Text(
                        ' $price ${tr("pound")}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${tr("wholesale_discount")} : $offer% ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red[800],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        ' $priceAfterOffer ${tr("pound")}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red[800],
                        ),
                      ),
                      Text(
                        ' $price ${tr("pound")}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(''),
              GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    isDismissible: false,
                    bounce: true,
                    context: context,
                    builder: (context) => ModalBottomSheetClass(
                      offerPrice: priceAfterOffer,
                      product: product,
                    ),
                  );
                },
                child: Container(
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(45),
                  margin: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(10),
                    0,
                    getProportionateScreenWidth(10),
                    0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFFEC40D),
                  ),
                  child: Center(
                    child: Text(
                      tr('add_to_cart'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

//      */
//       },
//       // OfferItem(offer: offers, index: index),
//     )));
class OfferItem extends StatefulWidget {
  final int index;
  final List offer;
  const OfferItem({
    this.index,
    this.offer,
    Key key,
  }) : super(key: key);

  @override
  _OfferItemState createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  @override
  Widget build(BuildContext context) {
    int price = int.parse(widget.offer[0]['products'][widget.index]['price']);
    int offer = widget.offer[0]['products'][widget.index]['offer'];
    int priceAfterOffer = price - (price * (offer / 100)).toInt();

    Product product = Product(
      name: widget.offer[0]['products'][widget.index]['name'],
      price: widget.offer[0]['products'][widget.index]['price'],
      offer: widget.offer[0]['products'][widget.index]['offer'].toString(),
      image: widget.offer[0]['products'][widget.index]['image'],
      id: widget.offer[0]['products'][widget.index]['id'],
      quantity:
          widget.offer[0]['products'][widget.index]['quantity'].toString(),
      extraQuantity: widget.offer[0]['products'][widget.index]['extraQuantity'],
    );
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(5),
          vertical: getProportionateScreenHeight(5)),
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(12),
          vertical: getProportionateScreenHeight(10)),
      width: getProportionateScreenWidth(160),
      // height: getProportionateScreenHeight(420),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(20)),
          border: Border.all(width: 1)),
      child: Column(
        children: [
          Image.network(
            '$imageUrl${product.image}',
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(100),
            fit: BoxFit.fill,
          ),
          Text(product.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Counter(text: tr("d_counter")),
              Counter(text: tr("d_counter")),
              Counter(text: tr("d_counter")),
              Counter(text: tr("d_counter")),
            ],
          ),
          Text(
            tr('elmansy_stores'),
            style: TextStyle(
              color: Colors.red[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr("retail_discount")} : $offer% ',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.red[800],
                ),
              ),
              Column(
                children: [
                  Text(
                    ' $priceAfterOffer ${tr("pound")}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red[800],
                    ),
                  ),
                  Text(
                    ' $price ${tr("pound")}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[400],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr("wholesale_discount")} : $offer% ',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.red[800],
                ),
              ),
              Column(
                children: [
                  Text(
                    ' $priceAfterOffer ${tr("pound")}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red[800],
                    ),
                  ),
                  Text(
                    ' $price ${tr("pound")}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(''),
          GestureDetector(
            onTap: () {
              showMaterialModalBottomSheet(
                isDismissible: false,
                bounce: true,
                context: context,
                builder: (context) => ModalBottomSheetClass(
                  offerPrice: priceAfterOffer,
                  product: product,
                ),
              );
            },
            child: Container(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(45),
              margin: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(10),
                0,
                getProportionateScreenWidth(10),
                0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFFEC40D),
              ),
              child: Center(
                child: Text(
                  tr('add_to_cart'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            '00',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 5,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
        ],
      ),
    );
  }
}

class OffersHeader extends StatelessWidget {
  final String title;
  const OffersHeader({
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      height: getProportionateScreenHeight(70),
      color: Colors.red[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: getProportionateScreenWidth(20)),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(55),
          ),
          SizedBox(
              child: SvgPicture.asset(
            'assets/icons/Offer.svg',
            width: 28,
            height: 28,
          )),
        ],
      ),
    );
  }
}
