import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/config/app_nearby_service.dart';
import 'package:base_bloc/data/globals.dart' as globals;
import 'package:base_bloc/data/nearby/nearby_data.dart';
import 'package:base_bloc/data/nearby/nearby_ext.dart';
import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../../data/model/playlist_model.dart';

class HomeCubit extends BaseCubit<HomeState> {
  var userRepository = UserRepository();

  HomeCubit() : super(HomeState()) {}

  @override
  void receivedStream(data) {
    super.receivedStream(data);
  }

  @override
  void listDeviceConnect(lDevice) {
    emit(HomeState(type: StatusType.showDialog, lDevice: lDevice));
  }

  void showConnectDevice(BuildContext context) {}

  void sentData() {
    appNearService
        .sentMessage(NearbyData(nearbyType: NearbyType.Login, data: "asdd"));
  }
}
