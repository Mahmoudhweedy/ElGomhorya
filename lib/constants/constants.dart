import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Color(0xFF333333),
  height: 1.5,
);
const defaultDuration = Duration(milliseconds: 250);
const kPrimaryColor = Color(0xFFFEC40D);
const kSecondryColor = Color(0xFFB51F32);
const kMyBlack = Color(0xFF333333);
// Form Error
final RegExp userNameValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]");
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final String kEmailNullError = tr('enter_mail');
final String kUserNameNullError = tr("enter_your_userName");
final String kInvalidEmailError = tr('invalid_email');
final String kInvalidUserNameError = tr("enter_vaild_username");
final String kPassNullError = tr("please_enter_your_password");
final String kShortPassError = tr('short_password');
final String kMatchPassError = tr('password_dont_match');
final String kFNamelNullError = tr("enter_fname");
final String kaddressNullError = tr("enter_address");
final String kPhoneNumberNullError = tr("please_enter_your_phone");
final String kPhoneNumberInvalidError = tr("invalid_mobile_number");
final String kStoreNameNullError = tr('enter_store_name');
const String image = 'https://dashboard.elgmhoria.com/uploads/';

const List<String> governments = [
  'الإسكندرية',
  'الإسماعيلية',
  'أسوان',
  'أسيوط',
  'الأقصر',
  'البحر الأحمر',
  'البحيرة',
  'بني سويف',
  'بورسعيد',
  'جنوب سيناء',
  'الجيزة',
  'الدقهلية',
  'دمياط',
  'سوهاج',
  'السويس',
  'الشرقية',
  'شمال سيناء',
  'الغربية',
  'الفيوم',
  'القاهرة',
  'القليوبية',
  'قنا',
  'كفر الشيخ',
  'مطروح',
  'المنوفية',
  'المنيا',
  'الوادي الجديد',
];
