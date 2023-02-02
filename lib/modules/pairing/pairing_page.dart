import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/appbar_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/modules/pairing/pairing_cubit.dart';
import 'package:base_bloc/modules/pairing/pairing_state.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../config/app_nearby_service.dart';
import '../../gen/assets.gen.dart';
import '../../theme/app_styles.dart';
import '../../utils/log_utils.dart';

class PairingPage extends StatefulWidget {
  const PairingPage({Key? key}) : super(key: key);

  @override
  State<PairingPage> createState() => _PairingPageState();
}

class _PairingPageState extends State<PairingPage> {
  late PairingCubit _bloc;

  @override
  void initState() {
    _bloc = PairingCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        fullStatusBar: true,
        resizeToAvoidBottomInset: false,
        appbar: appBarWidget(
            context: context,
            leading: const SizedBox(),
            leadingWidth: 0,
            titleStr: LocaleKeys.pairing.tr()),
        body: BlocBuilder<PairingCubit, PairingState>(
          bloc: _bloc,
          builder: (c, state) => state.type == StatusType.Init
              ? const Center(child: AppCircleLoading())
              : Center(child: lDeviceWidget(state)),
        ));
  }

  Widget lDeviceWidget(PairingState state) => Padding(
        padding: EdgeInsets.all(contentPadding),
        child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
                color: colorBlack.withOpacity(0.53),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (c, i) => itemDevice(state.lDevice[i]),
                    separatorBuilder: (c, i) => const SizedBox(height: 20),
                    itemCount: state.lDevice.length))),
      );

  Widget itemDevice(Device device) => InkWell(
      child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: AppText(device.deviceName,
                      maxLine: 1,
                      style: typoW600.copyWith(
                          color: colorText0, fontSize: 24.sp)),
                )),
                AppText(getStateName(device.state),
                    style:
                        typoW300.copyWith(color: colorText0, fontSize: 16.sp)),
                const SizedBox(width: 10),
                InkWell(
                    child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(Assets.svg.info,
                            color: colorWhite)),
                    onTap: () => _bloc.infoOnclick(device, context))
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(height: 0.3, color: Colors.grey)
          ])),
      onTap: () => _bloc.itemOnclick(device,context));

  String getStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return LocaleKeys.availableToConnect.tr();
      case SessionState.connecting:
        return LocaleKeys.connecting.tr();
      default:
        return LocaleKeys.notAvailable.tr();
    }
  }
}
