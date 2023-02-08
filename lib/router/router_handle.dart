import 'package:base_bloc/modules/home/home_page.dart';
import 'package:base_bloc/modules/login/login_page.dart';
import 'package:base_bloc/modules/pairing/pairing_page.dart';
import 'package:base_bloc/modules/splash/splash_page.dart';
import 'package:fluro/fluro.dart';

var routeLogin = Handler(handlerFunc: (c, p) => const LoginPage());
var routeHome = Handler(handlerFunc: (c, p) => const HomePage());
var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());
var routePairing = Handler(handlerFunc: (c, p) => const PairingPage());
