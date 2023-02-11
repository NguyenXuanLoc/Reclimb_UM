import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/routes_model.dart';

enum StatusType { init, showDialog }

class HomeState extends Equatable {
  final StatusType type;
  final List<UserInfoModel> lUserLogin;
  final List<UserInfoModel> lUserCache;
  final List<RoutesModel> lRoutes;
  final List<RoutesModel> lRoutesDrag;
  final RoutesModel? currentRoute;
  final int? timeStamp;

  const HomeState(
      {this.type = StatusType.init,
      this.lRoutes = const [],
      this.timeStamp,
      this.currentRoute,
      this.lRoutesDrag = const [],
      this.lUserLogin = const [],
      this.lUserCache = const []});

  HomeState copyOf({
    StatusType? type,
    int? timeStamp,
    required RoutesModel? currentRoute,
    List<UserInfoModel>? lUserLogin,
    List<UserInfoModel>? lUserCache,
    List<RoutesModel>? lRoutes,
    List<RoutesModel>? lRoutesDrag,
  }) =>
      HomeState(
        currentRoute: currentRoute,
        timeStamp: timeStamp ?? this.timeStamp,
        type: type ?? this.type,
        lUserLogin: lUserLogin ?? this.lUserLogin,
        lUserCache: lUserCache ?? this.lUserCache,
        lRoutes: lRoutes ?? this.lRoutes,
        lRoutesDrag: lRoutesDrag ?? this.lRoutesDrag,
      );

  @override
  List<Object?> get props =>
      [StatusType.init, lUserLogin, lUserCache, lRoutes, lRoutesDrag,timeStamp,currentRoute];
}
