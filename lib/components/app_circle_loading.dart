import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class AppCircleLoading extends StatelessWidget {
  const AppCircleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 30.h,
      child: const CircularProgressIndicator(
        color: colorOrange110,
        strokeWidth: 2.0,
      ),
    );
  }
}
