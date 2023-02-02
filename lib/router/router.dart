import 'package:base_bloc/router/router_handle.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static String root = "/";
  static String home = "/home";
  static String pairing = '/pairing';
  static String video = '/video';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeSplash);
    router.define(home, handler: routeHome);
    router.define(pairing, handler: routePairing);
  }
}
