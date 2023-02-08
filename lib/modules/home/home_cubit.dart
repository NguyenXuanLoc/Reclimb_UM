import 'dart:convert';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/nearby/nearby_data.dart';
import 'package:base_bloc/data/nearby/nearby_ext.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../data/fake_data.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    emit(HomeState(lUserLogin: lUserFake(), lUserCache: lUserCache()));
    getRoutes();
  }

  void stopDragOnClick()=>emit(state.copyOf(lRoutesDrag: []));

  void routeOnLongPress(RoutesModel model) =>
      emit(state.copyOf(lRoutesDrag: state.lRoutes
          .where((element) => element.userId == model.userId)
          .toList()));

  void dragItem(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    var model = state.lRoutesDrag.removeAt(oldIndex);
    state.lRoutesDrag.insert(newIndex, model);
    emit(state.copyOf(
        lRoutesDrag: state.lRoutesDrag,
        timeStamp: DateTime.now().microsecondsSinceEpoch));
  }

  void saveDragOnClick() {
    var userId = 0;
    if (state.lRoutesDrag.isNotEmpty) userId = state.lRoutesDrag[0].userId ?? 0;
    int indexOfDrag = 0;
    for (int i = 0; i < state.lRoutes.length; i++) {
      if (state.lRoutes[i].userId == userId) {
        state.lRoutes[i] = state.lRoutesDrag[indexOfDrag];
        indexOfDrag++;
      }
    }
    emit(state.copyOf(lRoutesDrag: [], lRoutes: state.lRoutes));
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

}
