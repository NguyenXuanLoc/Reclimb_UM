import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/modules/home/home_page.dart';
import 'package:base_bloc/modules/pairing/pairing_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../../config/app_nearby_service.dart';

class PairingCubit extends BaseCubit<PairingState> {
  PairingCubit() : super(const PairingState());

  @override
  void listDeviceConnect(lDevice) {
    emit(PairingState(lDevice: lDevice, type: StatusType.ScanSuccess));
  }

  void infoOnclick(Device device, BuildContext context) {
    Dialogs.showInfoDeviceDialog(context, connectCallBack: () {
      AppNearbyService.instance.startConnect(device);
      logE("TAG OPEN HOME");
      RouterUtils.pushTo(context, HomePage(), isReplace: true);
    }, device: device);
  }

  void itemOnclick(Device device,BuildContext context) {
    AppNearbyService.instance.startConnect(device);
    RouterUtils.pushTo(context, HomePage(), isReplace: true);
  }
}
