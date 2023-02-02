// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class Applocalizations extends AssetLoader {
  const Applocalizations();

  static const enCode = 'en';
  static const plCode = 'pl';
  static const localeEn = Locale(enCode);
  static const localePl = Locale(plCode);
  static const List<Locale> supportedLocales = <Locale>[localeEn, localePl];

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "title": "Poland",
    "appTitle": 'ReClimb PL',
    "climb": 'Climb',
    "home": 'Home',
    "profile": 'Profile',
    "reservations": 'Reservations',
    "routes": 'Routes',
    "appName": 'Climb',
    "public" : "Public",
    "private" : "Private",
    "draft": "Draft",
    "you_need_login_to_use_this_service": "You need login to use this service",
    'token_expired_please_login': "Session expired please login again",
    'availableToConnect': "Available to connect",
    'connecting': "Connecting",
    'notAvailable': "Not available",
    'pairing': "Pairing",
    'connect': "Connect",
    'id': "ID",
    'deviceName': "Device name",
    'status': "Status",
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    enCode: en,
    plCode: en
  };
}
