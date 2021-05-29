import '../models/ad.dart';
import '../models/orders.dart';
import '../models/reviews.dart';
import '../models/social.dart';
import '../models/terms.dart';
import '../models/cart.dart';
import '../models/offer.dart';
import '../models/categories.dart';
import '../models/slider.dart';
import '../models/stores.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  String baseUrl = "https://dashboard.elgmhoria.com/api/";

  FirebaseAuth auth = FirebaseAuth.instance;

  Future customerRegister(Guser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "${baseUrl}cst-reg";
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-type": "application/json"},
          body: convert.jsonEncode({
            "mobile": user.mobileNumber,
            "password": user.password,
            "l_name": user.lastName,
            "f_name": user.firstName,
            "user_name": user.userName,
            'address': user.address,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        prefs.setString("l_name", user.lastName);
        prefs.setString("f_name", user.firstName);
        prefs.setString("address", user.address);
        prefs.setString("mobile", user.mobileNumber);
        try {
          int id = convert.jsonDecode(response.body)["id"];
          print(id);
          prefs.setInt("id", id);
          return 1;
        } catch (e) {
          return 2;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future storeRegister(Stores store) async {
    var url = "${baseUrl}reg";
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-type": "application/json"},
          body: convert.jsonEncode({
            "mobile": store.mobileNumber,
            "password": store.password,
            "l_name": store.lastName,
            "f_name": store.firstName,
            "user_name": store.userName,
            "company_name": store.companyName,
            "city": store.city,
            "region": store.region,
            "email": store.email,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future login({@required String phone, @required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '${baseUrl}cst-login';
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-type": "application/json",
        },
        body: convert.jsonEncode({
          'mobile': phone,
          'password': password,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.contains("token")) {
          String accessToken = convert.jsonDecode(response.body)["token"]
              ["original"]["access_token"];
          int id = convert.jsonDecode(response.body)["user"][0]["id"];
          prefs.setString("access_token", accessToken);
          prefs.setString("mobile", phone);
          prefs.setString("password", password);

          prefs.setInt("id", id);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isLogedBefor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("mobile")) {
      bool res = await login(
          phone: prefs.getString("mobile"),
          password: prefs.getString("password"));
      return res;
    }
    return false;
  }

  // ------------------ forgetPassword ---------------- //
  Future resetPassword({String mobile, String newPassword}) async {
    print('form services$mobile $newPassword');
    var url = '${baseUrl}forget-password';
    print(url);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-type": "application/json",
        },
        body: convert.jsonEncode({
          'user_mobile': mobile,
          'password': newPassword,
        }),
      );
      print('form services2    $mobile $newPassword');
      print('response.statusCode ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('form services3    $mobile $newPassword');
        print(response.body);
      }
    } catch (e) {}
  }

// -------------------- get cart data ----------------  //
  Future getCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(Uri.parse('${baseUrl}user-cart'),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            "user_mobile": prefs.getString("mobile"),
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> cartProductsJson =
            List<Map<String, dynamic>>.from(
                convert.jsonDecode(response.body)["items"]);
        var totalCost = (convert.jsonDecode(response.body)["totalPrice"]);
        var totalQuantity =
            (convert.jsonDecode(response.body)["totalQuantity"]);
        print(
            'cartProductsJson[0]["shop_id"] = ${cartProductsJson[0]["shop_id"]}');
        List<CartProducts> cartProducts = cartProductsJson
            .map((cartProduct) => CartProducts.fromJson(cartProduct))
            .toList();
        print('my tot $totalCost');
        return [cartProducts, totalCost, totalQuantity];
      }
    } catch (e) {
      print(e);
    }
  }

// ----------- add to Cart --------- /
  Future<void> addToCart(
      {String mobileNumber, CartProducts product, String quantity}) async {
    print('product.shopId from services${product.shopId}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        "${baseUrl}add-to-cart?user_mobile=${prefs.getString("mobile")}&product_id=${product.productId}&product_name=${product.productName}&price=${product.price}&quantity=$quantity&type=${product.type}&shop_id=${product.shopId}";
    try {
      var response = await http.post(Uri.parse(url));
      // headers: <String, String>{
      //   "Content-type": "application/json",
      // },
      // body: convert.jsonEncode({
      //   'user_mobile': prefs.getString("mobile"),
      //    'product_id' : product.id,
      //   'product_name' : product.productName,
      //   'price':product.price,
      //   'quantity' : quantity,
      // }));
      if (response.statusCode == 200 || response.statusCode == 201) {

      }
    } catch (e) {
      print(e);
    }
  }

// -------------- delete from cart ----------- //
  Future<void> deleteFromCart({int id}) async {
    try {
      String url = "${baseUrl}cart/delete/$id";
      var res = await http.delete(Uri.parse(url));
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {}
  }
// ----------------- update cart ------------ //

  Future<void> updateCart({int cartId, String price, String quantity}) async {
    var url =
        "${baseUrl}update?cart_id=$cartId&price=$price&quantity=$quantity";

    try {
      var res = await http.post(Uri.parse(url));
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

  // ---------------------- increment ----------- //
  Future<void> cartItemIncrement({int cartId, String price}) async {
    var url = "${baseUrl}cart/inc-one-update";
    try {
      var res = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            'cart_id': cartId,
            'price': price,
          }));
      if (res.statusCode == 200 || res.statusCode == 201) {
        print("increment services ${res.body}");
        print(url);
      } else {
        print("increment services ${res.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  // ---------------------- deccrement ----------- //
  Future<void> cartItemDecrement({int cartId, String price}) async {
    var url = "${baseUrl}cart/dec-one-update";

    try {
      var res = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            'cart_id': cartId,
            'price': price,
          }));
      print(res.statusCode);

      if (res.statusCode == 200 || res.statusCode == 201) {
        print("increment services ${res.body}");
        print(res.statusCode);
        print(url);
      } else {
        print(res.body);
      }
    } catch (e) {
      print(e);
    }
  }

// -------------- getOrders ------------------ //
  Future<List<Orders>> getOrders() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}orders'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        List<Map<String, dynamic>> ordersJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        List orders =
            ordersJson.map((order) => Orders.fromJson(order)).toList();
        return orders;
      }
    } catch (e) {
      print(e);
    }
  }

// -------------------- get order data ----------------  //
  Future getOrdersData({String mobile}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(Uri.parse('${baseUrl}user-order'),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            "user_mobile": prefs.getString("mobile"),
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> ordersJson = List<Map<String, dynamic>>.from(
            convert.jsonDecode(response.body)["items"]);
        var totalCost = (convert.jsonDecode(response.body)["totalPrice"]);
        var totalQuantity =
            (convert.jsonDecode(response.body)["totalQuantity"]);
        // print('cartProductsJson[0]["shop_id"] = ${ordersJson[0]["shop_id"]}');
        List<Orders> orders =
            ordersJson.map((order) => Orders.fromJson(order)).toList();
        print('my tot $totalCost');
        return [orders, totalCost, totalQuantity];
      }
    } catch (e) {
      print(e);
    }
  }

// -------------- add to order -------------- //
  Future<void> addToOrders({
    String productPrice,
    String productQuantity,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobile = prefs.getString("mobile");
    String fName = prefs.getString("f_name");
    String lName = prefs.getString("l_name");
    try {
      var response = await http.post(Uri.parse('${baseUrl}add-to-order'),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            'user_mobile': mobile,
            'product_price': productPrice,
            'product_quantity': productQuantity,
            'user_f_name': fName,
            'user_l_name': lName,
          }));

      print(' myMobile $lName');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('response.body ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

// -------------- get user data ------------- //
  Future<Guser> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(Uri.parse('${baseUrl}cst-show'),
          headers: <String, String>{
            "Content-type": "application/json",
          },
          body: convert.jsonEncode({
            'userId': prefs.getInt('id'),
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> usersJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        List users = usersJson.map((user) => Guser.fromJson(user)).toList();
        return users[0];
      }
    } catch (e) {
      print(e);
    }
  }
  //  // ------------- get Slider  data --------- //

  Future<List<Sliders>> getSliders() async {
    try {
      var url = '${baseUrl}sliders';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> slidersJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        List sliders =
            slidersJson.map((slider) => Sliders.fromJson(slider)).toList();
        return sliders;
      }
    } catch (e) {
      print(e);
    }
  }

  // ------------- get Categories screen data --------- //

  Future<List<Categories>> getStoresCategories() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}categories'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> storesCategoriesJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        var storesCategories = storesCategoriesJson
            .map((storeCategory) => Categories.fromJson(storeCategory))
            .toList();
        return storesCategories;
      }
    } catch (e) {
      print(e);
    }
  }

  // ------------- get Stores screen data --------- //
  Future<List<Stores>> getStores() async {
    try {
      var url = '${baseUrl}user-show';
      var response = await http.get(Uri.parse(url));
      print(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('true ${response.statusCode}');

        List<Map<String, dynamic>> storesJson = List<Map<String, dynamic>>.from(
            convert.jsonDecode(response.body)["user"]);
        var stores = storesJson
            .map((storeCategory) => Stores.fromJson(storeCategory))
            .toList();
        return stores;
      } else {
        print('else ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  // --------------- get Latest offers ------------- //
  Future<LatestOffers> getLatestOffers() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}user-show'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> offersJson = Map<String, dynamic>.from(
            convert.jsonDecode(response.body)["latest_offers"]);
        var offers = LatestOffers.fromJson(offersJson);
        // print('offers ${offers.dailyOffers.length}');
        return offers;
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

// ------------- get reviews ----------- //
  Future<List<Review>> getReviews() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}show-app-rate'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> reviewsJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        var reviews =
            reviewsJson.map((review) => Review.fromJson(review)).toList();
        return reviews;
      }
    } catch (e) {
      print(e);
    }
  }

  // -------------- add Review -------------- //
  Future<void> addReview({String number, String comment}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMobile = prefs.getString("mobile");
    try {
      var response = await http.post(
        Uri.parse(
            '${baseUrl}add-to-app-rate?user_mobile=$userMobile&comment=$comment&number=$number'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

// ------------- get points ----------- //
  Future getPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userMobile = prefs.getString("mobile");
    try {
      var response = await http
          .get(Uri.parse('${baseUrl}user-points?user_mobile=$userMobile'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> reviewsJson =
            Map<String, dynamic>.from(convert.jsonDecode(response.body));
        return reviewsJson["point"];
      }
    } catch (e) {
      print(e);
    }
  }

  // ----------- get terms ------------ //
  Future<List<TermsAndConditions>> getTerms() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}items'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> termsJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        var terms =
            termsJson.map((term) => TermsAndConditions.fromJson(term)).toList();
        return terms;
      }
    } catch (e) {
      print(e);
    }
  }

  // ----------- get ads ------------ //
  Future<List<Ad>> getAds() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}ads'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> adsJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        var ads = adsJson.map((ad) => Ad.fromJson(ad)).toList();
        return ads;
      }
    } catch (e) {
      print(e);
    }
  }

  // ----------- get ads ------------ //
  Future getAdVideos() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}videos'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> adsJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        print("from services ${adsJson[0]["link"]}");
        return adsJson[0]["link"];
      }
    } catch (e) {
      print(e);
    }
  }

  // ----------- get SocailMedia ------------ //
  Future<List<Social>> getSocial() async {
    try {
      var response = await http.get(Uri.parse('${baseUrl}medias'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Map<String, dynamic>> mediaJson =
            List<Map<String, dynamic>>.from(convert.jsonDecode(response.body));
        var links = mediaJson.map((link) => Social.fromJson(link)).toList();
        return links;
      }
    } catch (e) {
      print(e);
    }
  }
}
