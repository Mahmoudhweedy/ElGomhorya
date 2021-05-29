import 'package:elgomhorya/user/settings.dart';

import './user/orders_screen.dart';

import './screens/about_us.dart';
import './screens/language_picker.dart';
import './screens/terms.dart';
import './screens/forget_password.dart';
import './screens/login_screen.dart';
import './store/congrats_screen.dart';
import './store/create_account_screen.dart';
import './screens/sign_choice.dart';
import './screens/welcome_screen.dart';
import './store/successful_register.dart';
import './user/cart.dart';
import './user/complete_register.dart';
import './user/create_user_account.dart';
import './user/categories_screen.dart';
import './user/home_screen.dart';
import './user/latest_offer.dart';
import './user/product_screen.dart';
import './user/products_screen.dart';
import './user/profile.dart';
import './user/reviews.dart';
import './user/verification_mobile.dart';
import 'package:flutter/material.dart';
import 'package:elgomhorya/user/saved_Location.dart';

import 'store/store_type_picker.dart';
import 'user/lang_country.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (_) => WelcomeScreen(),
  SignChoice.routeName: (_) => SignChoice(),
  CreateStoreAccount.routeName: (_) => CreateStoreAccount(),
  SuccessfullRegister.routeName: (_) => SuccessfullRegister(),
  CreateUserAccount.routeName: (_) => CreateUserAccount(),
  VerificationScreen.routeName: (_) => VerificationScreen(),
  CategoriesScreen.routeName: (_) => CategoriesScreen(),
  // CompaniesCategories.routeName: (_) => CompaniesCategories(),
  HomeScreen.routeName: (_) => HomeScreen(),
  ProductsScreen.routeName: (_) => ProductsScreen(),
  Cart.routeName: (_) => Cart(),
  Profile.routeName: (_) => Profile(),
  Reviews.routeName: (_) => Reviews(),
  CompleteRegister.routeName: (_) => CompleteRegister(),
  StoreTypePicker.routeName: (_) => StoreTypePicker(),
  Congrats.routeName: (_) => Congrats(),
  LatestOffer.routeName: (_) => LatestOffer(),
  LoginScreen.routeName: (_) => LoginScreen(),
  ProductScreen.routeName: (_) => ProductScreen(),
  LanguagePicker.routeName: (_) => LanguagePicker(),
  AboutUs.routeName: (_) => AboutUs(),
  Terms.routeName: (_) => Terms(),
  LanguageAndCountries.routeName: (_) => LanguageAndCountries(),
  OrderScreen.routeName: (_) => OrderScreen(),
  ForgetPassword.routeName : (_) => ForgetPassword(),
  Settings.routeName :(_) => Settings(),
  SavedLocations.routeName : (_) => SavedLocations(),
};
