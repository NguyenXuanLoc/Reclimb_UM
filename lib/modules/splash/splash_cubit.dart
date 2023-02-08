import 'dart:async';

import 'package:base_bloc/modules/home/home_page.dart';
import 'package:base_bloc/modules/splash/splash_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../root/root_home_page.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitState()) {
    Timer(const Duration(seconds: 1), () => emit(OpenHomeState()));
  }

  void openHomePage(BuildContext context) =>
      RouterUtils.pushTo(context, const RootHomePage(),isReplace: true);
}
