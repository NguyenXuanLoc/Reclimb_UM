import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/routes_model.dart';

enum StatusType { init, showDialog }

class HomeState extends Equatable {
  final StatusType type;
  final List<UserInfoModel> lUserLogin;
  final List<UserInfoModel> lUserCache;
  final List<RoutesModel> lRoutes;

  const HomeState(
      {this.type = StatusType.init,
      this.lRoutes = const [],
      this.lUserLogin = const [],
      this.lUserCache = const []});

  HomeState copyOf(
          {StatusType? type,
          List<UserInfoModel>? lUserLogin,
          List<UserInfoModel>? lUserCache,
          List<RoutesModel>? lRoutes}) =>
      HomeState(
          type: type ?? this.type,
          lUserLogin: lUserLogin ?? this.lUserLogin,
          lUserCache: lUserCache ?? this.lUserCache,
          lRoutes: lRoutes ?? this.lRoutes);

  @override
  List<Object?> get props => [StatusType.init, lUserLogin, lUserCache, lRoutes];
}
