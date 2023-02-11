import 'package:base_bloc/components/app_not_data_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/components/item_info_route.dart';
import 'package:base_bloc/components/item_user.dart';
import 'package:base_bloc/components/reservation_status_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/modules/home/home_cubit.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/info_user_model.dart';
import '../../data/model/routes_model.dart';
import '../routers_detail/routes_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _bloc;
  final routesDetailController = RoutesDetailController();
  @override
  void initState() {
    _bloc = HomeCubit(routesDetailController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Column(
      children: [
        // appbarWidget(),
        Expanded(
            child: Row(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
                bloc: _bloc,
                builder: (c, state) => state.currentRoute != null
                    ? routeDetailWidget()
                    : climberWidget()),
            Container(
                height: MediaQuery.of(context).size.height,
                width: 1.w,
                color: colorBlack),
            playlistWidget()
          ],
        ))
      ],
    ));
  }

  Widget routeDetailWidget() => Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _bloc,
          builder: (c, state) => RoutesDetailPage(
              goBackCallback: () => _bloc.dismissRouteDetail(),
              model: state.currentRoute!,
              controller: routesDetailController)));

  Widget climberWidget() => Expanded(
          child: Padding(
        padding: EdgeInsets.all(contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(LocaleKeys.climber.tr(),
              style: typoW600.copyWith(fontSize: 22.sp)),
            AppText(
              LocaleKeys.logged.tr(),
              style: typoW400.copyWith(
                  fontSize: 16.sp, color: colorText0.withOpacity(0.87)),
            ),
            space(),
            Expanded(
                flex: 3,
                child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (c, state) => state.lUserLogin.isEmpty
                        ? const Center(child: AppNotDataWidget())
                        : lUserWidget(state.lUserLogin, logoutCallback: () {}),
                    bloc: _bloc)),
            space(),
            buttonLoginWithPhone(),
            space(),
            loginWithAccountWidget(),
            space(),
            AppText(LocaleKeys.loginAs.tr(),
                style: typoW400.copyWith(
                    fontSize: 16.sp, color: colorText0.withOpacity(0.87))),
            space(),
            Expanded(
                flex: 9,
                child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (c, state) => state.lUserCache.isEmpty
                        ? const Center(child: AppNotDataWidget())
                        : lUserWidget(state.lUserCache),
                    bloc: _bloc)),
            space(height: 10),
          ],
        ),
      ));

  Widget loginWithAccountWidget() => Row(
        children: [
          GradientButton(
              height: 36.h,
              isCenter: true,
              borderRadius: BorderRadius.circular(30),
              width: MediaQuery.of(context).size.width / 4.5,
              decoration: BoxDecoration(
                  border: Border.all(color: colorWhite.withOpacity(0.87)),
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                      colors: [Colors.transparent, Colors.transparent])),
              onTap: () => _bloc.loginWithAccOnClick(context),
              widget: AppText(LocaleKeys.loginWithAccount.tr(),
                  style:
                      typoW600.copyWith(fontSize: 14.sp, color: colorText0))),
          const Spacer(),
          TextButton(
              onPressed: () {},
              child: AppText(
                LocaleKeys.createAnAccount.tr(),
                style: typoW600.copyWith(
                    color: const Color(0xffFF5A00), fontSize: 14.sp),
              )),
          const SizedBox(width: 10)
        ],
      );

  Widget buttonLoginWithPhone() => GradientButton(
      height: 36.h,
      isCenter: true,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [Color(0xffFF9300), Color(0xffFF5A00)])),
      onTap: () {},
      widget: AppText(
        LocaleKeys.loginWithPhone.tr(),
        style: typoW600.copyWith(fontSize: 14.sp, color: colorText0),
      ));

  Widget lUserWidget(List<UserInfoModel> lUser,
          {VoidCallback? logoutCallback}) =>
      ListView.separated(
          itemBuilder: (c, i) =>
              ItemUser(model: lUser[i], logoutCallback: logoutCallback),
          separatorBuilder: (c, i) => const SizedBox(height: 10),
          itemCount: lUser.length);

  Widget playlistWidget() => Expanded(
          child: Padding(
        padding: EdgeInsets.all(contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(LocaleKeys.playlist.tr(),
                    style: typoW600.copyWith(fontSize: 22.sp)),
                const Spacer(),
                const Spacer(),
                BlocBuilder<HomeCubit, HomeState>(
                    builder: (c, state) => Visibility(
                      visible: state.lRoutesDrag.isNotEmpty,
                      child: InkWell(
                          onTap: () => _bloc.saveDragOnClick(),
                          child: const Icon(Icons.done_all,
                              color: Colors.white, size: 15)),
                    ),
                    bloc: _bloc),
                const Spacer(),
                BlocBuilder<HomeCubit, HomeState>(
                    builder: (c, state) => Visibility(
                      visible: state.lRoutesDrag.isNotEmpty,
                      child: InkWell(
                          onTap: () => _bloc.stopDragOnClick(),
                          child: const Icon(Icons.clear,
                              color: Colors.white, size: 15)),
                    ),
                    bloc: _bloc)
              ],
            ),
            AppText(
              LocaleKeys.dragAndDropToChangeOrder.tr(),
              style: typoW400.copyWith(
                  fontSize: 16.sp, color: colorText0.withOpacity(0.6)),
            ),
            space(),
            Expanded(child: playlistContentWidget())
          ],
        ),
      ));

  Widget playlistContentWidget() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _bloc,
      builder: (c, state) => state.lRoutesDrag.isNotEmpty
          ? lDragWidget(state)
          : state.lRoutes.isEmpty
              ? const Center(child: AppNotDataWidget())
              : lRoutesWidget(state.lRoutes));

  Widget lRoutesWidget(List<RoutesModel> lRoutesModel) =>
      ListView.separated(
          itemBuilder: (context, index) => ItemInfoRoutes(
              context: context,
              model: lRoutesModel[index],
              onLongPressCallBack: (model) => _bloc.routeOnLongPress(model),
              callBack: (model) {
                logE("TAG ONTAB: $model");
              },
              index: index,
              detailCallBack: (model)=>_bloc.itemRouteOnClick(model)),
          separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 5),
          itemCount: lRoutesModel.length);

  Widget lDragWidget(HomeState state) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ReorderableListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (c, i) => Container(
                key: Key('$i'),
                color: Colors.transparent,
                padding: const EdgeInsets.only(bottom: 5),
                child: ItemInfoRoutes(
                    isDrag: true,
                    context: context,
                    model: state.lRoutesDrag[i],
                    onLongPressCallBack: (model) {},
                    callBack: (model) {},
                    index: i,
                    detailCallBack: (model) {})),
            itemCount: state.lRoutesDrag.length,
            onReorder: (int oldIndex, int newIndex) =>
                _bloc.dragItem(oldIndex, newIndex)));
  }

  Widget appbarWidget() => Container(
      padding: EdgeInsets.only(
          left: contentPadding, right: contentPadding, top: 10, bottom: 14.h),
      color: colorBlack,
      child: Row(
        children: [
          Expanded(
              child: AppText(LocaleKeys.climber.tr(),
                  style: typoW600.copyWith(fontSize: 22.sp))),
          Expanded(
              child: Row(
            children: [
              AppText(LocaleKeys.playlist.tr(),
                  style: typoW600.copyWith(fontSize: 22.sp)),
              const Spacer(),
              const Spacer(),
              BlocBuilder<HomeCubit, HomeState>(
                  builder: (c, state) => Visibility(
                        visible: state.lRoutesDrag.isNotEmpty,
                        child: InkWell(
                            onTap: () => _bloc.saveDragOnClick(),
                            child: const Icon(Icons.done_all,
                                color: Colors.white, size: 15)),
                      ),
                  bloc: _bloc),
              const Spacer(),
              BlocBuilder<HomeCubit, HomeState>(
                  builder: (c, state) => Visibility(
                        visible: state.lRoutesDrag.isNotEmpty,
                        child: InkWell(
                            onTap: () => _bloc.stopDragOnClick(),
                            child: const Icon(Icons.clear,
                                color: Colors.white, size: 15)),
                      ),
                  bloc: _bloc)
            ],
          ))
        ],
      ));


  Widget space({double? height}) => SizedBox(height: height ?? 10.h);

  Widget reservationInfoWidget() => Column(
        children: [
          Row(children: [
            AppText(LocaleKeys.reservation.tr(),
                style: typoW400.copyWith(fontSize: 14.sp)),
            const Spacer(),
            AppText("10:10", style: typoW400.copyWith(fontSize: 14.sp))
          ]),
          SizedBox(height: 6.h),
          Row(
            children: [
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
                          fontSize: 22.sp,
                          color: colorText0.withOpacity(0.87))),
                  const ReservationStatusWidget(),
                ],
              ))
            ],
          ),
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
                          fontSize: 16.sp,
                          color: colorText0.withOpacity(0.87))))
            ],
          ),
        ],
      );
}
