import 'package:elgomhorya/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProducts {
  final int id;
  final String productId,
      productName,
      productImage,
      price,
      quantity,
      package,
      shopId,
      type,
      userMobile;

  CartProducts({
    this.id,
    @required this.productId,
    @required this.productName,
    @required this.productImage,
    @required this.price,
    @required this.quantity,
    @required this.shopId,
    this.type,
    this.package,
    this.userMobile,
  });
  factory CartProducts.fromJson(Map json) {
    return CartProducts(
      shopId: json['shop_id'].toString(),
      id: json['id'],
      package: json['package'],
      price: json['price'],
      productId: json['product_id'].toString(),
      productImage: json['product_image'],
      productName: json['product_name'],
      quantity: json['quantity'].toString(),
      userMobile: json['user_mobile'],
      type: json['type'],
    );
  }
}

class CartData extends ChangeNotifier {
  List<CartProducts> cartItems = [];

  void setInitItems(List<CartProducts> items) {
    cartItems = items;
    // notifyListeners();
  }

  void addProduct({CartProducts product}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartItems.add(product);
    await Services().addToCart(
      mobileNumber: prefs.getString("mobile"),
      product: product,
      quantity: product.quantity,
    );
    cartItems.forEach((element) {
      print('product from add Product${element.shopId} ');
    });

    notifyListeners();
  }

  void removeProduct(CartProducts product) async {
    print(product.id);
    await Services().deleteFromCart(id: product.id);
    cartItems.remove(product);
    print('product.id ${product.id}');

    notifyListeners();
  }
}
