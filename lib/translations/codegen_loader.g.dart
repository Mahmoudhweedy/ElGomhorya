// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar_EG = {
  "welcome": "مرحباً",
  "application_name": "شارع الجمهورية",
  "app_purpose": "لمعدات ومستلزمات المصانع",
  "app_description": "أكبر تطبيق للمعدات ومستلزمات المصانع في الوطن العربي"
};
static const Map<String,dynamic> en_US = {
  "welcome": "welcome",
  "application_name": "Gomhorya Street",
  "app_purpose": "For factories equipments and supplies",
  "app_description": "The Biggest Application for factories equipments and supplies in Arab country"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar_EG": ar_EG, "en_US": en_US};
}
