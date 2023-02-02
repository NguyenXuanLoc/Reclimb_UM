import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDeviceDialog extends StatefulWidget {
  final Device deviceModel;
  final VoidCallback connectCallBack;

  const InfoDeviceDialog(
      {Key? key, required this.deviceModel, required this.connectCallBack})
      : super(key: key);

  @override
  State<InfoDeviceDialog> createState() => _InfoDeviceDialogState();
}

class _InfoDeviceDialogState extends State<InfoDeviceDialog> {
  var isShowInfo = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(maxHeight: 200, minHeight: 200),
        decoration: BoxDecoration(
            color: colorBlack.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemContent(LocaleKeys.id.tr(), widget.deviceModel.deviceId),
            itemContent(
                LocaleKeys.deviceName.tr(), widget.deviceModel.deviceName),
            itemContent(
                LocaleKeys.status.tr(), getStateName(widget.deviceModel.state)),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                button(Utils.backgroundGradientOrangeButton(),
                    LocaleKeys.connect.tr(), () {
                  widget.connectCallBack.call();
                  RouterUtils.pop(context);
                }),
                const SizedBox(width: 10),
                button(
                    const LinearGradient(colors: [Colors.white, Colors.white]),
                    LocaleKeys.cancel.tr(),
                    () => RouterUtils.pop(context)),
              ],
            ))
          ],
        ));
  }

  Widget button(Gradient gradient, String content, VoidCallback callback) =>
      GradientButton(
          width: 145.w,
          height: 30,
          isCenter: true,
          decoration: BoxDecoration(
              gradient: gradient, borderRadius: BorderRadius.circular(30)),
          onTap: () => callback.call(),
          widget: AppText(
            content,
            style: typoW600.copyWith(color: colorText100, fontSize: 20.sp),
          ));

  Widget itemContent(String title, String content) => Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 5),
                  child: AppText(title,
                      style: typoW600.copyWith(
                          fontSize: 20.sp, color: colorText0)))),
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: AppText(content,
                  style:
                      typoW600.copyWith(fontSize: 20.sp, color: colorText0))),
          const SizedBox(width: 40),
        ],
      );

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
