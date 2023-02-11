import 'dart:convert';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/data/eventbus/dismiss_tooltip_event.dart';
import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/nearby/nearby_data.dart';
import 'package:base_bloc/data/nearby/nearby_ext.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../data/fake_data.dart';
import '../../utils/app_utils.dart';
import '../routers_detail/routes_detail_page.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final RoutesDetailController routesDetailController;

  HomeCubit(this.routesDetailController) : super(const HomeState()) {
    emit(HomeState(lUserLogin: lUserFake(), lUserCache: lUserCache()));
    getRoutes();
  }

  void loginWithAccOnClick(BuildContext context) =>
      RouterUtils.pushHome(context: context, route: HomeRouters.login);

  void stopDragOnClick() =>
      emit(state.copyOf(lRoutesDrag: [], currentRoute: state.currentRoute));

  void routeOnLongPress(RoutesModel model) => emit(state.copyOf(
      lRoutesDrag: state.lRoutes
          .where((element) => element.userId == model.userId)
          .toList(),
      currentRoute: state.currentRoute));

  void dragItem(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    var model = state.lRoutesDrag.removeAt(oldIndex);
    state.lRoutesDrag.insert(newIndex, model);
    emit(state.copyOf(
        lRoutesDrag: state.lRoutesDrag,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        currentRoute: state.currentRoute));
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
    emit(state.copyOf(
        lRoutesDrag: [],
        lRoutes: state.lRoutes,
        currentRoute: state.currentRoute));
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
    emit(state.copyOf(lRoutes: lResponse, currentRoute: state.currentRoute));
  }

  void itemRouteOnClick(RoutesModel model) {
    emit(state.copyOf(currentRoute: model));
    routesDetailController.setRoutes = model;
    Utils.fireEvent(DismissTooltipEvent());
  }

  void dismissRouteDetail() {
    logE("TAG DIS MISS");
    // emit(HomeState());
    emit(state.copyOf(
        timeStamp: DateTime.now().microsecondsSinceEpoch, currentRoute: null));
  }

  void moveToTopOnClick(int currentIndex, RoutesModel model) {
    var lRoutesByUserId = state.lRoutes
        .where((element) => element.userId == model.userId)
        .toList();
    for (int i = 0; i < lRoutesByUserId.length; i++) {
      if (lRoutesByUserId[i].id == model.id) {
        lRoutesByUserId.removeAt(i);
      }
    }
    lRoutesByUserId.insert(0, model);
    int count = 0;
    for (int i = 0; i < state.lRoutes.length; i++) {
      if (state.lRoutes[i].userId == model.userId) {
        state.lRoutes[i] = lRoutesByUserId[count];
        count++;
      }
    }
    emit(state.copyOf(
        lRoutes: state.lRoutes,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        currentRoute: state.currentRoute));
    toast("SUCCESS");
  }

  void moveToBottomOnClick(int index, RoutesModel model) {
    var lRoutesByUserId = state.lRoutes
        .where((element) => element.userId == model.userId)
        .toList();
    for (int i = 0; i < lRoutesByUserId.length; i++) {
      if (lRoutesByUserId[i].id == model.id) {
        lRoutesByUserId.removeAt(i);
      }
    }
    lRoutesByUserId.add(model);
    int count = 0;
    for (int i = 0; i < state.lRoutes.length; i++) {
      if (state.lRoutes[i].userId == model.userId) {
        state.lRoutes[i] = lRoutesByUserId[count];
        count++;
      }
    }
    emit(state.copyOf(
        lRoutes: state.lRoutes,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        currentRoute: state.currentRoute));
    toast("SUCCESS");
  }

  void removeFromPlaylistOnClick(int index, RoutesModel model) {
    state.lRoutes.removeAt(index);
    emit(state.copyOf(
        lRoutes: state.lRoutes,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        currentRoute: state.currentRoute));
    toast("REMOVE SUCCESS");
  }

  void loginAsOnclick(int index,BuildContext context) {
    // Dialogs.showLoginAccountDialog(context, model: state.lUserCache[index]);
    emit(state.copyOf(
        currentRoute: state.currentRoute,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        lUserLogin: state.lUserLogin
          ..add(state.lUserCache[index].copyOf(isLogin: true))));
    toast("LOGIN SUCCESS");
  }

  void logoutOnClick(int index) {
    if (state.lUserLogin[index].isHighlight) {
      toast("ROUTES OF USER IS SETTING UP, CAN NOT LOGOUT");
      return;
    }
    toast("LOGOUT SUCCESS");
    var model = state.lUserLogin.removeAt(index);
    state.lUserCache.add(model.copyOf(isLogin: false));
    emit(state.copyOf(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        currentRoute: state.currentRoute,
        lUserLogin: state.lUserLogin,
        lUserCache: state.lUserCache));
  }
}
