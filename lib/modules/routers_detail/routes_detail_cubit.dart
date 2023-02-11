import 'dart:async';

import 'package:base_bloc/data/model/routes_model.dart';
import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/routers_detail/routes_detail_page.dart';
import 'package:base_bloc/modules/routers_detail/routes_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/dialogs.dart';
import '../../data/eventbus/refresh_event.dart';
import '../../data/globals.dart' as globals;
import '../../utils/app_utils.dart';
import '../../utils/toast_utils.dart';

class RoutesDetailCubit extends Cubit<RoutesDetailState> {
  var userRepository = UserRepository();
  final bool isSaveDraft;
  final int row, column;

  RoutesDetailCubit(RoutesModel model, this.isSaveDraft, this.row, this.column)
      : super(RoutesDetailState(status: RoutesStatus.initial, model: model)) {
    getRouteDetail(model);
  }


  Future<void> getRouteDetail(RoutesModel model) async {
    emit(RoutesDetailState(model: model, status: RoutesStatus.initial));
    var response =/* globals.isLogin
        ? await userRepository.getRouteDetail(model.id ?? '')
        : */await userRepository.getRouteDetailAno(model.id ?? '');
    if (response.data != null && response.error == null) {
      getInfoHoldSet(RoutesModel.fromJson(response.data).copyOf(height: 3));
    } else {
      toast(response.error.toString());
      emit(state.copyOf(status: RoutesStatus.failure));
    }
  }

  void getInfoHoldSet(RoutesModel model) {
    var lHoldSet = [];
    for (int i = 0; i < row * column; i++) {
      lHoldSet.add('');
    }
    var lResponse = Utils.getHold(model.holds ?? []);
    for (var element in lResponse) {
      lHoldSet[element.index] = element;
    }
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            timeStamp: DateTime.now().microsecondsSinceEpoch,
            status: RoutesStatus.success,
            model: model,
            lHoldSet: lHoldSet)));
  }

  void handleAction(RoutesAction action, BuildContext context,
      VoidCallback? publishCallback) {
    if (!globals.isLogin) {
      return;
    }
    switch (action) {
      case RoutesAction.INFO:
        return;
      case RoutesAction.COPY:
        copyRoutes(context, state.model);
        return;
      case RoutesAction.SHARE:
        shareRoutes(context, state.model);
        return;
      case RoutesAction.ADD_FAVOURITE:
        addOrRemoveFavorite(context, state.model, true);
        return;
      case RoutesAction.REOMVE_FROM_FAV:
        addOrRemoveFavorite(context, state.model, false);
        return;
      case RoutesAction.ADD_TO_PLAY_LIST:
        addOrRemoveToPlaylist(context, state.model, true);
        return;
      case RoutesAction.REMOVE_FROM_PLAYLIST:
        addOrRemoveToPlaylist(context, state.model, false);
        return;
      case RoutesAction.PUBLISH:
        publishOnClick(state.model, context, publishCallback);
        return;
      case RoutesAction.EDIT:
        editRoutes(context, state.model);
    }
  }

  void copyRoutes(BuildContext context, RoutesModel model) => null;

  void shareRoutes(BuildContext context, RoutesModel model) async {
    Dialogs.showLoadingDialog(context);
    await Future.delayed(const Duration(seconds: 1));
    await Dialogs.hideLoadingDialog();
    toast('Share post success');
  }

  void publishOnClick(RoutesModel model, BuildContext context,
      VoidCallback? publishCallback) async {
/*    Dialogs.showLoadingDialog(context);
    var response = await userRepository.editRoute(
        routeId: model.id.toString(),
        visibility: model.visibility ?? 0,
        height: model.height ?? 9,
        name: model.name ?? '',
        lHold: Utils.getHold(model.holds ?? ''),
        hasCorner: model.hasConner ?? false,
        authorGrade: model.authorGrade ?? 0);
    await Dialogs.hideLoadingDialog();
    if (response.statusCode == 200 && response.error == null) {
      if (isSaveDraft) {// save draft khi tao route.
        RouterUtils.openNewPage(HomePage(), context, isReplace: true);
        return;
      }
      model.published = true;
      if (publishCallback != null) publishCallback.call();
      toast(LocaleKeys.publish_routes_success.tr());
      emit(state.copyOf(
          model: model, timeStamp: DateTime.now().microsecondsSinceEpoch));
    } else {
      toast(response.error.toString());
    }*/
  }

  void editRoutes(
    BuildContext context,
    RoutesModel model,
  ) =>
      null;

  void addOrRemoveFavorite(
      BuildContext context, RoutesModel model, bool isAdd) async {}

  void addOrRemoveToPlaylist(
    BuildContext context,
    RoutesModel model,
    bool isAdd,
  ) async {
    Dialogs.showLoadingDialog(context);
  }

  void refreshRouteTab() {
    Utils.fireEvent(RefreshEvent(RefreshType.FAVORITE));
    Utils.fireEvent(RefreshEvent(RefreshType.PLAYLIST));
  }

  void editRouteOnclick(BuildContext context, RoutesModel model) async {}
}
