import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/router/application.dart';
import 'package:base_bloc/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/base_state.dart';
import '../../components/app_text.dart';
import '../../components/reservation_status_widget.dart';
import '../../data/globals.dart';
import '../../localization/locale_keys.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class RootHomePage extends StatefulWidget {
  const RootHomePage({Key? key}) : super(key: key);

  @override
  State<RootHomePage> createState() => _RootHomePageState();
}

class _RootHomePageState extends BaseState<RootHomePage> {
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'RootHome');

  @override
  void initState() {
    configRouter();
    super.initState();
  }

  void configRouter() {
    var router = FluroRouter();
    HomeRouters.configureRoutes(router);
    Application.homeRouter = router;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          appbarWidget(),
          Expanded(
              child: WillPopScope(
                  child: Navigator(
                    key: navigatorKey,
                    onGenerateRoute: Application.homeRouter.generator,
                  ),
                  onWillPop: () async => navigatorKey.currentState!.canPop()))
        ],
      ),
    );
  }

  Widget appbarWidget() => Container(
      padding: EdgeInsets.only(
          left: contentPadding, right: contentPadding, top: 10),
      color: colorBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reservationInfoWidget(),
          space(),
          Container(height: 0.15, color: colorWhite.withOpacity(0.4))
        ],
      ));

  Widget reservationInfoWidget() => Column(children: [
        Row(children: [
          AppText(LocaleKeys.reservation.tr(),
              style: typoW400.copyWith(fontSize: 14.sp)),
          const Spacer(),
          AppText("10:10", style: typoW400.copyWith(fontSize: 14.sp))
        ]),
        SizedBox(height: 6.h),
        Row(children: [
          AppText(LocaleKeys.now.tr(),
              style: typoW400.copyWith(
                  fontSize: 16.sp, color: colorText0.withOpacity(0.6))),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText("10:00 - 10:30 Adam Kowalski",
                  style: typoW600.copyWith(
                      fontSize: 22.sp, color: colorText0.withOpacity(0.87))),
              const ReservationStatusWidget(),
            ],
          ))
        ]),
        space(),
        Row(
          children: [
            AppText(LocaleKeys.now.tr(),
                style: typoW400.copyWith(
                    fontSize: 16.sp, color: colorText0.withOpacity(0.6))),
            const SizedBox(width: 17),
            Expanded(
                child: AppText("10:00 - 10:30 Adam Kowalski",
                    style: typoW600.copyWith(
                        fontSize: 16.sp, color: colorText0.withOpacity(0.87))))
          ],
        ),
      ]);

  Widget space({double? height}) => SizedBox(height: height ?? 10.h);
}
