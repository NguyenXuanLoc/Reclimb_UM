import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../config/app_nearby_service.dart';
import '../data/repository/user_repository.dart';

class BaseCubit<T> extends Cubit<T> {
  var appNearService = AppNearbyService();
  var userRepository = UserRepository();

  BaseCubit(super.initialState) {
    appNearService.setReceivedCallBack((p0) => receivedStream(p0));
    appNearService.setlDeviceCallBack((p0) => listDeviceConnect(p0));
  }

  void receivedStream(dynamic data) {
    toast("SAS" + data.toString());
  }

  void listDeviceConnect(List<Device> lDevice) {}
}
