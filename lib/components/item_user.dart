import 'dart:async';

import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/components/tooltip/src/tooltip.dart';
import 'package:base_bloc/components/tooltip/src/types.dart';
import 'package:base_bloc/data/eventbus/dismiss_tooltip_event.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../data/model/info_user_model.dart';
import '../gen/assets.gen.dart';

class ItemUser extends StatefulWidget {
  final VoidCallback? logoutCallback;
  final VoidCallback? loginCallback;
  final UserInfoModel model;

  const ItemUser({Key? key, required this.model, this.logoutCallback, this.loginCallback})
      : super(key: key);

  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  var isShowInfo = false;
  StreamSubscription<DismissTooltipEvent>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription =
        Utils.eventBus.on<DismissTooltipEvent>().listen((event) {
      if (isShowInfo) {
        setState(() => isShowInfo = false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.logoutCallback != null
        ? tooltip(contentToolTip())
        : itemContent();
  }

  Widget contentToolTip() => GradientButton(
      onTap: () {
        widget.logoutCallback?.call();
        isShowInfo = !isShowInfo;
        setState(() {});
      },
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      widget: Row(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset(
          Assets.svg.logout,
          width: 18.w,
        ),
        const SizedBox(width: 7),
        AppText(LocaleKeys.logout.tr(),
            style: typoW500.copyWith(
                color: colorText0,
                fontSize: 16.sp,
                decoration: TextDecoration.none)),
        const SizedBox(width: 90)
      ]));

  Widget itemContent() => GradientButton(
      borderRadius: BorderRadius.circular(16),
      widget: Container(
          height: 72.h,
          margin: widget.model.isHighlight
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                  colors: [Colors.transparent, Colors.transparent])),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Visibility(
                visible: widget.model.isHighlight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.circle,
                      size: 5, color: colorWhite.withOpacity(0.87)),
                )),
            SizedBox(width: widget.model.isHighlight ? 10 : 20),
            Stack(
              children: [
                SizedBox(
                    width: 56.w,
                    height: 56.w,
                    child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                            child: Image.network(widget.model.avatar ?? '',
                                fit: BoxFit.cover,
                                width: 56.w,
                                height: 56.w)))),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 25.h),
                    decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(Icons.circle,
                        size: 10,
                        color: widget.model.isLogin
                            ? const Color(0xff42AB06)
                            : const Color(0xffFF7326)),
                  ),
                ))
              ],
            ),
            SizedBox(width: 25.w),
            AppText(widget.model.userName,
                style: typoW600.copyWith(
                    fontSize: 22.sp, color: colorText0.withOpacity(0.87)))
          ])),
      onTap: () {
        widget.loginCallback?.call();
        Utils.fireEvent(DismissTooltipEvent());
        Timer(const Duration(milliseconds: 100),
            () => setState(() => isShowInfo = !isShowInfo));
      },
      height: 72.h,
      decoration: BoxDecoration(
          color: const Color(0xff121212),
          borderRadius: BorderRadius.circular(16)));

  Widget tooltip(Widget content) => SimpleTooltip(
      minimumOutSidePadding: 0,
      animationDuration: const Duration(seconds: 1),
      show: isShowInfo,
      borderColor: Colors.transparent,
      borderRadius: 5,
      targetCenter: const Offset(2, 1),
      ballonPadding: const EdgeInsets.only(left: 0),
      backgroundColor: Colors.black,
      tooltipMargin:
          EdgeInsets.only(left: MediaQuery.of(context).size.width / 9),
      tooltipDirection: TooltipDirection.center,
      content: content,
      child: itemContent());
}
