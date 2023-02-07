import 'dart:async';

import 'package:base_bloc/components/tooltip/src/tooltip.dart';
import 'package:base_bloc/components/tooltip/src/types.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/eventbus/dismiss_tooltip_event.dart';
import '../data/globals.dart';
import '../data/model/background_param.dart';
import '../data/model/routes_model.dart';
import '../gen/assets.gen.dart';
import '../localization/locale_keys.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/app_utils.dart';
import '../utils/log_utils.dart';
import 'app_text.dart';
import 'gradient_button.dart';

class ItemInfoRoutes extends StatefulWidget {
  final BuildContext context;
  final RoutesModel model;
  final bool isShowSelect;
  final bool isDrag;
  final Function(RoutesModel model)? onLongPressCallBack;
  final Function(RoutesModel model) callBack;
  final Function(RoutesModel action) detailCallBack;
  final Function(RoutesModel model)? removeSelectCallBack;
  final VoidCallback? filterOnclick;
  final Function(RoutesModel model)? doubleTapCallBack;
  final int index;

  const ItemInfoRoutes(
      {Key? key,
      this.isDrag = false,
      this.onLongPressCallBack,
      required this.context,
      required this.model,
      required this.callBack,
      required this.index,
      required this.detailCallBack,
      this.filterOnclick,
      this.removeSelectCallBack,
      this.isShowSelect = false,
      this.doubleTapCallBack})
      : super(key: key);

  @override
  State<ItemInfoRoutes> createState() => _ItemInfoRoutesState();
}

class _ItemInfoRoutesState extends State<ItemInfoRoutes> {
  var isShowTooltip = false;
  StreamSubscription<DismissTooltipEvent>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription =
        Utils.eventBus.on<DismissTooltipEvent>().listen((event) {
      if (isShowTooltip) {
        setState(() => isShowTooltip = false);
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
    var infoBackground =
        Utils.getBackgroundColor(widget.model.authorGrade ?? 0);
    return Container(
        padding: EdgeInsets.only(bottom: widget.model.isHighLight ? 6 : 0),
        height: widget.model.isHighLight ? 96.h : 72.h,
        key: Key('${widget.index}'),
        child: tooltip(
            contentToolTip(),
            !widget.isDrag
                ? GradientButton(
                    borderRadius: BorderRadius.circular(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            stops: infoBackground.stops,
                            colors: infoBackground.colors)),
                    onDoubleTab: tooltipOnclick,
                    onTap: () => widget.isShowSelect
                        ? widget.filterOnclick?.call()
                        : widget.detailCallBack.call(widget.model),
                    onLongPress: () =>
                        widget.onLongPressCallBack?.call(widget.model),
                    widget: content(infoBackground))
                : GradientButton(
                    borderRadius: BorderRadius.circular(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            stops: infoBackground.stops,
                            colors: infoBackground.colors)),
                    onTap: () => widget.isShowSelect
                        ? widget.filterOnclick?.call()
                        : widget.detailCallBack.call(widget.model),
                    onDoubleTab: tooltipOnclick,
                    widget: content(infoBackground))
            ));
  }

  void tooltipOnclick() {
    Utils.fireEvent(DismissTooltipEvent());
    Timer(const Duration(milliseconds: 100),
        () => setState(() => isShowTooltip = !isShowTooltip));
  }

  Widget contentToolTip() => SizedBox(
      width: MediaQuery.of(context).size.width / 3.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          itemToolTip(Assets.svg.removeFromPlaylist,
              LocaleKeys.removeFromPlaylist.tr()),
          Divider(height: 0.08, color: colorWhite.withOpacity(0.4)),
          itemToolTip(Assets.svg.moveToTop, LocaleKeys.moveToTopPlaylist.tr()),
          Divider(height: 0.08, color: colorWhite.withOpacity(0.4)),
          itemToolTip(
              Assets.svg.moveToBottom, LocaleKeys.moveToBottomPlaylist.tr()),
        ],
      ));

  Widget itemToolTip(String icon, String content) => Padding(
      //To do
      padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, width: 16.w),
          const SizedBox(width: 7),
          AppText(content,
              style: typoW400.copyWith(
                  decoration: TextDecoration.none,
                  fontSize: 16.sp,
                  color: colorText0)),
          const Spacer()
        ],
      ));

  Widget tooltip(Widget contentTooltip, Widget contentWidget) => SimpleTooltip(
      minimumOutSidePadding: 0,
      animationDuration: const Duration(seconds: 1),
      show: isShowTooltip,
      borderColor: Colors.transparent,
      borderRadius: 5,
      targetCenter: const Offset(2, 1),
      ballonPadding: const EdgeInsets.only(left: 0),
      backgroundColor: Colors.black,
      tooltipMargin: EdgeInsets.only(
          right: MediaQuery.of(widget.context).size.width / 2.5),
      tooltipDirection: TooltipDirection.center,
      content: contentTooltip,
      child: contentWidget);

  Widget content(BackgroundParam infoBackground) {
    return Container(
      margin: widget.model.isHighLight
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 8, right: 8),
      padding: EdgeInsets.only(
          left:
              widget.model.isHighLight ? (contentPadding + 8) : contentPadding,
          right:
              widget.model.isHighLight ? (contentPadding + 8) : contentPadding),
      height: widget.model.isHighLight ? 96.h : 72.h,
      width: MediaQuery.of(widget.context).size.width,
      child: Row(
        children: [
          Visibility(
            visible: widget.isDrag,
            child: const Expanded(
                flex: 2,
                child: Icon(
                  Icons.dehaze,
                  color: colorWhite,
                )),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            flex: !widget.isDrag ? 3 : 4,
            child: widget.model.hasConner == false
                ? AppText(Utils.getGrade(widget.model.authorGrade ?? 0),
                    style: googleFont.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorText0,
                        fontSize: 31.sp))
                : Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          Utils.getGrade(widget.model.authorGrade ?? 0),
                          style: googleFont.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w700,
                              color: colorText0,
                              fontSize: 29.sp),
                        ),
                        AppText(
                          " ${LocaleKeys.corner.tr()}",
                          style: typoW400.copyWith(
                              height: 1,
                              color: colorWhite.withOpacity(0.87),
                              fontSize: 12.7.sp),
                        ),
                      ],
                    ),
                  ),
          ),
          Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    widget.model.name ?? '',
                    style: googleFont.copyWith(
                        color: colorText0.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.5.sp),
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  (widget.model.published ?? true)
                      ? Row(
                          children: [
                            AppText(
                              '${LocaleKeys.routes.tr()} ${widget.model.height}m ',
                              style: googleFont.copyWith(
                                  color: colorText0.withOpacity(0.6),
                                  fontSize: 13.sp),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.w, right: 3.w),
                              child: Icon(
                                Icons.circle_sharp,
                                size: 6,
                                color: colorText0.withOpacity(0.6),
                              ),
                            ),
                            Expanded(
                                child: AppText(
                                    widget.model.userProfile != null
                                        ? " ${widget.model.userProfile?.firstName} ${widget.model.userProfile?.lastName}"
                                        : " ${widget.model.authorFirstName} ${widget.model.authorLastName}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLine: 1,
                                    style: googleFont.copyWith(
                                        color: colorText0.withOpacity(0.6),
                                        fontSize: 13.sp)))
                          ],
                        )
                      : Row(children: [
                          AppText(
                            '${LocaleKeys.routes.tr()} ${widget.model.height}m ',
                            style: googleFont.copyWith(
                                color: colorText0.withOpacity(0.6),
                                fontSize: 13.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Icon(
                              Icons.circle_sharp,
                              size: 6,
                              color: colorText0.withOpacity(0.6),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: colorWhite),
                              padding: EdgeInsets.only(
                                  left: 7.w, right: 7.w, top: 2.h, bottom: 2.h),
                              child: AppText(LocaleKeys.draft.tr(),
                                  style: typoW400.copyWith(
                                      fontSize: 11.sp, color: colorText90)))
                        ])
                ],
              ))
        ],
      ),
    );
  }
}
