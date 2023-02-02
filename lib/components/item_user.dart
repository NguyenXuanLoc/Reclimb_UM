import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/model/info_user_model.dart';

class ItemUser extends StatelessWidget {
  final UserInfoModel model;

  const ItemUser({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72.h,
        margin: model.isHighlight
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: const Color(0xff121212),
            borderRadius: BorderRadius.circular(16)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Visibility(
              visible: model.isHighlight,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.circle,
                    size: 5, color: colorWhite.withOpacity(0.87)),
              )),
          SizedBox(width: model.isHighlight ? 10 : 20),
          Stack(
            children: [
              SizedBox(
                  width: 56.w,
                  height: 56.w,
                  child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                          child: Image.network(model.avatar ?? '',
                              fit: BoxFit.cover, width: 56.w, height: 56.w)))),
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
                      color: model.isLogin
                          ? const Color(0xff42AB06)
                          : const Color(0xffFF7326)),
                ),
              ))
            ],
          ),
          SizedBox(width: 25.w),
          AppText(model.userName,
              style: typoW600.copyWith(
                  fontSize: 22.sp, color: colorText0.withOpacity(0.87)))
        ]));
  }
}
