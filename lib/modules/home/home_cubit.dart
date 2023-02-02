import 'dart:convert';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/nearby/nearby_data.dart';
import 'package:base_bloc/data/nearby/nearby_ext.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    emit(HomeState(lUserLogin: lUserFake(), lUserCache: lUserCache()));
    getRoutes();
  }

  void showConnectDevice(BuildContext context) {}

  void sentData() {
    appNearService
        .sentMessage(NearbyData(nearbyType: NearbyType.Login, data: "asdd"));
  }

  Future<void> getRoutes() async {
    final String response =
        await rootBundle.loadString('assets/json/routes.json');
    final data = await json.decode(response);
    var lResponse = routeModelFromJson(data['data']['routes']);
    lResponse[2].isHighLight = true;
    emit(state.copyOf(lRoutes: lResponse));
  }

  List<UserInfoModel> lUserFake() => [
        UserInfoModel(
            'https://noithatbinhminh.com.vn/wp-content/uploads/2022/08/anh-dep-56.jpg',
            "Adam Kowalski",
            true,
            false),
        UserInfoModel(
            'https://i.9mobi.vn/cf/images/2015/03/nkk/nhung-hinh-anh-dep-14.jpg',
            "Zoe Smith",
            true,
            true),
        UserInfoModel(
            'https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-de-thuong.jpg',
            "Anna Novak",
            true,
            false),
        UserInfoModel(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Wmp6ghw6G16qhGQUMiXJZ0vHtEDS1fqtE8jtsKA&s',
            "Paul Koval",
            true,
            false)
      ];

  List<UserInfoModel> lUserCache() => [
        UserInfoModel(
            'https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-de-thuong.jpg',
            "Anna Novak",
            false,
            false),
        UserInfoModel(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Wmp6ghw6G16qhGQUMiXJZ0vHtEDS1fqtE8jtsKA&s',
            "Paul Koval",
            false,
            false),
        UserInfoModel(
            'https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-de-thuong.jpg',
            "Anna Novak",
            false,
            false),
        UserInfoModel(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Wmp6ghw6G16qhGQUMiXJZ0vHtEDS1fqtE8jtsKA&s',
            "Paul Koval",
            false,
            false),
        UserInfoModel(
            'https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-de-thuong.jpg',
            "Anna Novak",
            false,
            false),
        UserInfoModel(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Wmp6ghw6G16qhGQUMiXJZ0vHtEDS1fqtE8jtsKA&s',
            "Paul Koval",
            false,
            false)
      ];
}
