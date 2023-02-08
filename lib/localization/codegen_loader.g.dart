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
    "public": "Public",
    "private": "Private",
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
    'reservation': "Reservations",
    'now': "Now",
    'next': "Next",
    'climber': "Climber",
    'logged': "Logged",
    'dragAndDropToChangeOrder': "Drag and drop to change order",
    'loginWithPhone': "Login with phone",
    'loginWithAccount': "Login with account",
    'createAnAccount': "Create with account",
    'loginAs': "Login as",
    'playlist': "Playlist",
    'not_data': "Not data",
    'logout': "Logout",
    'removeFromPlaylist': "Remove from playlist",
    'moveToTopPlaylist': "Move to top playlist",
    'moveToBottomPlaylist': "Move to bottom playlist",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    enCode: en,
    plCode: en
  };
}
