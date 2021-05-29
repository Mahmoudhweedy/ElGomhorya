import 'package:easy_localization/easy_localization.dart';
import '../constants/custom_drawer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/constants.dart';
import '../constants/my_app_bar.dart';
import '../models/products.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'products_screen.dart';

final String imageUrl = '${image}products/';

class ProductScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static String routeName = '/product_screen';
  final Product product;
  String priceAfterDiscount({int price, String offer}) {
    double myOffer = double.parse(offer);
    double offerPrice = price.toDouble() - (price.toDouble() * (myOffer * .01));
    offerPrice.toInt();
    return offerPrice.toStringAsFixed(0);
  }

  ProductScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              radius: 0,
              screenName: product.name,
              onPress: () {
                _scaffoldKey.currentState.openDrawer();
              },
              isDrawer: false,
            ),
            Image.network(
              '$imageUrl${product.image}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: SizeConfig.screenHeight * .4,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.description,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          product.offer == null
                              ? Column(
                                  children: [
                                    Text(tr("price"),
                                        textAlign: TextAlign.center),
                                    Text(' ${product.price} ${tr("egp")}',
                                        textAlign: TextAlign.center),
                                  ],
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                          ' ${priceAfterDiscount(
                                            offer: product.offer.toString(),
                                            price: int.parse(product.price),
                                          )} ${tr("egp")}',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18),
                                          textAlign: TextAlign.center),
                                      Text(' ${product.price} ${tr("egp")}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey[400]),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    'وصف المنتج',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.longDescription,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: getProportionateScreenHeight(140)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          isDismissible: false,
                          bounce: true,
                          context: context,
                          builder: (context) => ModalBottomSheetClass(
                            priceAfterDiscount: priceAfterDiscount,
                            product: product,
                          ),
                        );
                      },
                      child: Container(
                        width: getProportionateScreenWidth(200),
                        height: getProportionateScreenHeight(70),
                        margin: EdgeInsets.fromLTRB(
                          getProportionateScreenWidth(10),
                          getProportionateScreenHeight(10),
                          getProportionateScreenWidth(10),
                          getProportionateScreenHeight(10),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFFEC40D),
                        ),
                        child: Center(
                          child: Text(
                            tr('add_to_cart'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalBottomSheetClass extends StatefulWidget {
  final Product product;
  final Function priceAfterDiscount;
  final int offerPrice;
  const ModalBottomSheetClass({
    Key key,
    this.offerPrice,
    this.product,
    this.priceAfterDiscount,
  }) : super(key: key);

  @override
  _ModalBottomSheetClassState createState() => _ModalBottomSheetClassState();
}

class _ModalBottomSheetClassState extends State<ModalBottomSheetClass> {
  int _wholeSaleQuantity = 0;
  int _retialQuantity = 0;
  int _totalCost = 0;
  _incrementWholesale() {
    setState(() {
      _wholeSaleQuantity += 10;
    });
    _countTotalCost();
  }

  _decrementWholesale() {
    if (_wholeSaleQuantity > 0) {
      setState(() {
        _wholeSaleQuantity -= 10;
      });
      _countTotalCost();
    }
  }

  _incrementRetial() {
    setState(() {
      _retialQuantity++;
    });
    _countTotalCost();
  }

  _decrementRetial() {
    if (_retialQuantity > 0) {
      setState(() {
        _retialQuantity--;
      });
      _countTotalCost();
    }
  }

  void _countTotalCost() {
    int wholeSaleQuantityTotalCost =
        _wholeSaleQuantity * int.parse(widget.product.price);
    int retialQuantityTotalCost =
        _retialQuantity * int.parse(widget.product.price);
    setState(() {
      _totalCost = wholeSaleQuantityTotalCost + retialQuantityTotalCost;
    });
  }

  String unit;
  @override
  Widget build(BuildContext context) {
    List<String> _units = List.generate(widget.product.extraQuantity.length,
        (index) => '${widget.product.extraQuantity[index]["name"]}');
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        height: SizeConfig.screenHeight * .75,
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(30)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      widget.product.name,
                      textAlign: TextAlign.center,
                    ),
                    widget.product.offer == null
                        ? Column(
                            children: [
                              Text(tr("price"), textAlign: TextAlign.center),
                              Text(' ${widget.product.price} ${tr("egp")}',
                                  textAlign: TextAlign.center),
                            ],
                          )
                        : Container(
                            child: Column(
                              children: [
                                Text(tr("price_before_discount"),
                                    textAlign: TextAlign.center),
                                Text(' ${widget.product.price} ${tr("egp")}',
                                    textAlign: TextAlign.center),
                                Text(tr("price_after_discount"),
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center),
                                Text(
                                    widget.priceAfterDiscount != null
                                        ? ' ${widget.priceAfterDiscount(
                                            offer: widget.product.offer,
                                            price:
                                                int.parse(widget.product.price),
                                          )} ${tr("egp")}'
                                        : '${widget.offerPrice}',
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                  ],
                ),
                Container(
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(130),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1.5,
                      color: Color(0xFF333333),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      '$imageUrl${widget.product.image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            BottomSheetDivider(
              title: tr("wholesale"),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              ' ${widget.product.price} ${tr("egp")}',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ItemsCount(
              quantity: _wholeSaleQuantity,
              increment: () {
                _incrementWholesale();
              },
              decrement: () {
                _decrementWholesale();
              },
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            DropdownButton<String>(
                items: _units.map((String val) {
                  return new DropdownMenuItem<String>(
                    value: val,
                    child: new Text(val),
                  );
                }).toList(),
                hint: unit == null ? Text('اختار وحدة القياس') : Text(unit),
                onChanged: (newVal) {
                  setState(() {
                    unit = newVal;
                  });
                  print(unit);
                }),
            BottomSheetDivider(title: tr("retial")),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(' ${widget.product.price} ${tr("egp")}',
                textAlign: TextAlign.center),
            SizedBox(height: getProportionateScreenHeight(20)),
            ItemsCount(
              quantity: _retialQuantity,
              increment: () {
                _incrementRetial();
              },
              decrement: () {
                _decrementRetial();
              },
            ),
            Spacer(),
            BottomBar(
              quantity: _retialQuantity == 0
                  ? _wholeSaleQuantity
                  : (_retialQuantity + _wholeSaleQuantity),
              totalCost: _totalCost,
              product: widget.product,
            ),
          ],
        ),
      ),
    );
  }
}
