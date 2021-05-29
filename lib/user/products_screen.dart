import 'package:easy_localization/easy_localization.dart';
import 'package:elgomhorya/constants/my_btn_nav_bar.dart';
import '../constants/ads_bar.dart';
import '../constants/custom_drawer.dart';
import '../constants/my_app_bar.dart';
import '../models/cart.dart';
import '../models/products.dart';
import '../size_config.dart';
import '../user/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

class ProductsScreen extends StatefulWidget {
  final List productsJson;
  static String routeName = '/products';
  ProductsScreen({Key key, this.productsJson}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String imageUrl = '${image}products/';

  String priceAfterDiscount({int price, String offer}) {
    double myOffer = double.parse(offer);
    double offerPrice = price.toDouble() - (price.toDouble() * (myOffer * .01));
    offerPrice.toInt();
    return offerPrice.toStringAsFixed(0);
  }

  var products;

  @override
  void initState() {
    products = widget.productsJson
        .map((storeCategory) => Product.fromJson(storeCategory))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
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
                      _scaffoldKey.currentState.openDrawer();
                    },
                    radius: 20,
                    screenName: tr("products")),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(10),
                  ),
                  child: Text(
                    tr("products"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 100),
                  child: Wrap(
                    children:
                        List.generate(widget.productsJson.length, (index) {
                      if (index == 4) {
                        return ADSBar();
                      }
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProductScreen(product: products[index]))),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          margin: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10),
                              vertical: getProportionateScreenHeight(10)),
                          width: getProportionateScreenWidth(160),
                          height: widget.productsJson[index]["offer"] == null
                              ? getProportionateScreenHeight(300)
                              : null,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment:
                                widget.productsJson[index]["offer"] == null
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                child: Image.network(
                                  "$imageUrl${widget.productsJson[index]["image"]}",
                                  fit: BoxFit.contain,
                                ),
                                height: getProportionateScreenHeight(90),
                                width: getProportionateScreenWidth(40),
                              ),
                              Text(
                                widget.productsJson[index]["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              widget.productsJson[index]["offer"] == null
                                  ? Column(
                                      children: [
                                        Text(tr("price"),
                                            textAlign: TextAlign.center),
                                        Text(
                                            ' ${widget.productsJson[index]["price"]} ${tr("egp")}',
                                            textAlign: TextAlign.center),
                                      ],
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Text(tr("price_before_discount"),
                                              textAlign: TextAlign.center),
                                          Text(
                                              ' ${widget.productsJson[index]["price"]} ${tr("egp")}',
                                              textAlign: TextAlign.center),
                                          Text(tr("price_after_discount"),
                                              style:
                                                  TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center),
                                          Text(
                                              ' ${priceAfterDiscount(
                                                offer: widget
                                                    .productsJson[index]
                                                        ["offer"]
                                                    .toString(),
                                                price: int.parse(
                                                    widget.productsJson[index]
                                                        ["price"]),
                                              )} ${tr("egp")}',
                                              style:
                                                  TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                              GestureDetector(
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    isDismissible: false,
                                    bounce: true,
                                    context: context,
                                    builder: (context) => ModalBottomSheetClass(
                                      productPrice: 200,
                                      index: index,
                                      priceAfterDiscount: priceAfterDiscount,
                                      products: products,
                                    ),
                                  );
                                },
                                child: Container(
                                  width: getProportionateScreenWidth(100),
                                  height: getProportionateScreenHeight(45),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )),
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

class ModalBottomSheetClass extends StatefulWidget {
  final int productPrice;
  final List<Product> products;
  final int index;
  final Function priceAfterDiscount;
  const ModalBottomSheetClass({
    Key key,
    @required this.productPrice,
    this.products,
    this.index,
    this.priceAfterDiscount,
  }) : super(key: key);

  @override
  _ModalBottomSheetClassState createState() => _ModalBottomSheetClassState();
}

class _ModalBottomSheetClassState extends State<ModalBottomSheetClass> {
  int _wholeSaleQuantity = 0;
  int _retialQuantity = 0;
  int _totalCost = 0;
  int wholeSaleQuantityTotalCost = 0;
  int retialQuantityTotalCost = 0;
  String unit;
  int unitCurrentIndex = 0;
  int _retialPrice;
  int _wholeSalePrice;
  _incrementWholesale(int price) {
    setState(() {
      _wholeSaleQuantity += 5;
    });
    print("increment price $price");
    print("w quantity $_wholeSaleQuantity");
    _countTotalCost(price, _retialPrice);
  }

  _decrementWholesale(int price) {
    print("increment price $price");
    print("w quantity $_wholeSaleQuantity");
    if (_wholeSaleQuantity > 0) {
      setState(() {
        _wholeSaleQuantity -= 5;
      });
      _countTotalCost(price, _retialPrice);
    }
  }

  _incrementRetial(int price) {
    setState(() {
      _retialQuantity++;
    });
    print("increment price $price");
    print("w quantity $wholeSaleQuantityTotalCost");
    _countTotalCost(_wholeSalePrice, price);
  }

  _decrementRetial(int price) {
    print("increment price $price");
    print("w quantity $_retialQuantity");
    if (_retialQuantity > 0) {
      setState(() {
        _retialQuantity--;
      });
      _countTotalCost(_wholeSalePrice, price);
    }
  }

  void _countTotalCost(int wholeSalePrice, int retialPrice) {
    wholeSaleQuantityTotalCost = _wholeSaleQuantity * wholeSalePrice;
    retialQuantityTotalCost = _retialQuantity * retialPrice;
    setState(() {
      _totalCost = wholeSaleQuantityTotalCost + retialQuantityTotalCost;
    });
  }

  Widget build(BuildContext context) {
    _retialPrice = int.parse(widget.products[widget.index].price);
    _wholeSalePrice = widget.products[widget.index].extraQuantity[unitCurrentIndex]["pivot"]["price"];
    List<String> _units = List.generate(
        widget.products[widget.index].extraQuantity.length,
        (index) =>
            '${widget.products[widget.index].extraQuantity[index]["name"]}');
    Widget _wholesalePrice() {
      String price = widget.products[widget.index].extraQuantity.isNotEmpty
          ? '${widget.products[widget.index].extraQuantity[unitCurrentIndex]["pivot"]["price"]} ${tr("egp")}'
          : '${widget.products[widget.index].price} ${tr("egp")}';
      setState(() {});
      return Text(
        price,
        style: TextStyle(color: Colors.red),
      );
    }

    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        height: SizeConfig.screenHeight * .75,
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      widget.products[widget.index].name,
                      textAlign: TextAlign.center,
                    ),
                    widget.products[widget.index].offer == null
                        ? Column(
                            children: [
                              Text(tr("price"), textAlign: TextAlign.center),
                              Text(
                                  ' ${widget.products[widget.index].price} ${tr("egp")}',
                                  textAlign: TextAlign.center),
                            ],
                          )
                        : Container(
                            child: Column(
                              children: [
                                Text(tr("price_before_discount"),
                                    textAlign: TextAlign.center),
                                Text(
                                    ' ${widget.products[widget.index].price} ${tr("egp")}',
                                    textAlign: TextAlign.center),
                                Text(tr("price_after_discount"),
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center),
                                Text(
                                    ' ${widget.priceAfterDiscount(
                                      offer:
                                          widget.products[widget.index].offer,
                                      price: int.parse(
                                          widget.products[widget.index].price),
                                    )} ${tr("egp")}',
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                  ],
                ),
                Container(
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(100),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  child: Image.network(
                    "$imageUrl${widget.products[widget.index].image}",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            BottomSheetDivider(
              title: tr("wholesale"),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            _wholesalePrice(),
            SizedBox(height: getProportionateScreenHeight(10)),
            ItemsCount(
              quantity: _wholeSaleQuantity,
              increment: () {
                // print("_wholeSaleQuantity $_wholeSaleQuantity");
                widget.products[widget.index].extraQuantity.isNotEmpty
                    ? _incrementWholesale(int.parse(
                        '${widget.products[widget.index].extraQuantity[widget.index]["pivot"]["price"]}'))
                    : _incrementWholesale(
                        int.parse('${widget.products[widget.index].price}'));
              },
              decrement: () {
                widget.products[widget.index].extraQuantity.isNotEmpty
                    ? _decrementWholesale(int.parse(
                        '${widget.products[widget.index].extraQuantity[widget.index]["pivot"]["price"]}'))
                    : _decrementWholesale(
                        int.parse('${widget.products[widget.index].price}'));
              },
            ),
            SizedBox(height: getProportionateScreenHeight(9)),
            _units.isNotEmpty
                ? DropdownButton<String>(
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
                        for (int i = 0; i < _units.length; i++) {
                          if (_units[i] == newVal) {
                            unitCurrentIndex = i;
                          }
                        }
                      });
                      // print("unit $unit");
                    })
                : SizedBox(height: 20),
            SizedBox(height: getProportionateScreenHeight(10)),
            BottomSheetDivider(title: tr("retial")),
            SizedBox(height: getProportionateScreenHeight(20)),
            widget.products[widget.index].offer == null
                ? Text(' ${widget.products[widget.index].price} ${tr("egp")}',
                    textAlign: TextAlign.center)
                : Text(
                    '${widget.priceAfterDiscount(
                      offer: widget.products[widget.index].offer,
                      price: int.parse(widget.products[widget.index].price),
                    )} ${tr("egp")}',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center),
            SizedBox(height: getProportionateScreenHeight(20)),
            ItemsCount(
              quantity: _retialQuantity,
              increment: () {
                // print("_retialQuantity  $_retialQuantity");
                widget.products[widget.index].offer == null
                    ? _incrementRetial(
                        int.parse("${widget.products[widget.index].price}"))
                    : _incrementRetial(int.parse('${widget.priceAfterDiscount(
                        offer: widget.products[widget.index].offer,
                        price: int.parse(widget.products[widget.index].price),
                      )}'));
              },
              decrement: () {
                widget.products[widget.index].offer == null
                    ? _decrementRetial(
                        int.parse("${widget.products[widget.index].price}"))
                    : _decrementRetial(int.parse('${widget.priceAfterDiscount(
                        offer: widget.products[widget.index].offer,
                        price: int.parse(widget.products[widget.index].price),
                      )}'));
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Spacer(),
            BottomBar(
              productUnit: unit ?? "قطعة",
              quantity: _retialQuantity == 0
                  ? _wholeSaleQuantity
                  : (_retialQuantity + _wholeSaleQuantity),
              totalCost: _totalCost,
              product: widget.products[widget.index],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final String productUnit;
  final int quantity;
  final Product product;
  final int totalCost;
  const BottomBar({
    this.productUnit,
    this.quantity,
    this.product,
    Key key,
    @required this.totalCost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("quantity from bottom $quantity");
    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(80),
      color: Color(0xFF333333),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: getProportionateScreenWidth(100),
            color: Color(0xFF333333),
            child: Text(' $totalCost ${tr("egp")}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFEC40D),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
          ),
          GestureDetector(
            onTap: () {
              // print("pro ${product.id}");
              if (!Provider.of<CartData>(context, listen: false)
                  .cartItems
                  .contains(product)) {
                // print('myproduct ${product.id.toString()}');

                Provider.of<CartData>(context, listen: false).addProduct(
                    product: CartProducts(
                  productId: product.id.toString(),
                  price: totalCost.toString(),
                  productImage: product.image,
                  productName: product.name,
                  quantity: "$quantity",
                  type: productUnit ?? "قطعة",
                  shopId: product.userId,
                ));
                // print("product.userId ${product.userId}");
                // print('product ${product.id.toString()}');
                // print('productq ${product.quantity.toString()}');
                // print("my$productUnit");
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("المنتج موجود بالفعل")));
              }
            },
            child: Container(
              width: getProportionateScreenWidth(170),
              height: getProportionateScreenHeight(80),
              color: Colors.red[800],
              child: Center(
                child: Text(
                  tr("add_to_your_cart"),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: getProportionateScreenWidth(105),
            color: Color(0xFF333333),
            child: SvgPicture.asset(
              'assets/icons/Cart red.svg',
              color: Colors.yellow[900],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsCount extends StatelessWidget {
  final int quantity;
  final Function increment;
  final Function decrement;
  ItemsCount({
    @required this.quantity,
    Key key,
    @required this.increment,
    @required this.decrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge = false;
    if (quantity >= 100) {
      isLarge = true;
    }
    // print("quantity $quantity");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isLarge,
          child: Container(
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenHeight(50),
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: increment,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            alignment: Alignment.center,
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(border: Border.all(width: 1)),
          ),
        ),
        Container(
          height: getProportionateScreenHeight(50),
          width: getProportionateScreenWidth(50),
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
          onTap: decrement,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            alignment: Alignment.center,
            child: Text(
              "-",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(border: Border.all(width: 1)),
          ),
        ),
      ],
    );
  }
}

class BottomSheetDivider extends StatelessWidget {
  final String title;
  const BottomSheetDivider({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(19.7)),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
