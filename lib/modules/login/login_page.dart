import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/appbar_widget.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/modules/login/login_cubit.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/base_state.dart';
import '../../components/gradient_button.dart';
import '../../utils/app_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePopState<LoginPage> {
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  late LoginCubit _bloc;

  @override
  void initState() {
    _bloc = LoginCubit();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppScaffold(
        padding: EdgeInsets.only(
            top: contentPadding + 20.h,
            left: MediaQuery.of(context).size.width / 5,
            right: MediaQuery.of(context).size.width / 5),
        appbar: appbar(),
        body: BlocBuilder<LoginCubit, LoginState>(
            bloc: _bloc,
            builder: (c, state) => Column(
                  children: [
                    textField(
                      errorText: state.errorEmail,
                      labelText: LocaleKeys.email_address.tr(),
                      controller: emailController,
                      obText: false,
                    ),
                    textField(
                        errorText: state.errorPass,
                        labelText: LocaleKeys.password.tr(),
                        icon: Icons.remove_red_eye,
                        controller: passWordController,
                        voidCallback: () => _bloc.showPass(),
                        obText: state.isShowPass),
                    GradientButton(
                      height: 36.h,
                      decoration: BoxDecoration(
                          gradient: Utils.backgroundGradientOrangeButton(),
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () => _bloc.loginOnclick(
                          emailController, passWordController, context),
                      widget: Center(
                          child: AppText(
                        LocaleKeys.login.tr(),
                        style: googleFont.copyWith(
                            color: colorWhite.withOpacity(0.7),
                            fontSize: 17.sp),
                      )),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    space,
                    AppText(
                      LocaleKeys.forgotPassword.tr(),
                      style: googleFont.copyWith(
                          color: colorPrimaryOrange100, fontSize: 15.5.sp),
                    )
                  ],
                )));
  }

  var space = SizedBox(height: 20.h);

  Widget textField(
      {required String labelText,
      IconData? icon,
      String? errorText,
      required TextEditingController controller,
      required bool obText,
      VoidCallback? voidCallback}) {
    return SizedBox(
        height: 95.h,
        child: TextFormField(
            obscureText: obText,
            style: typoW500.copyWith(
                color: colorWhite.withOpacity(0.7), fontSize: 18.sp),
            controller: controller,
            cursorColor: colorOrange90,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 15.w),
                isDense: true,
                errorText: errorText!.isEmpty ? null : errorText,
                labelText: labelText,
                labelStyle: googleFont.copyWith(
                    color: errorText!.isNotEmpty
                        ? colorSemanticRed100
                        : colorText0.withOpacity(0.7),
                    fontSize: 18.sp),
                errorStyle: googleFont.copyWith(
                    color: colorSemanticRed100, fontSize: 18.sp),
                suffixIcon: InkWell(
                    splashColor: colorTransparent,
                    hoverColor: colorTransparent,
                    onTap: voidCallback,
                    child: Icon(icon, color: colorGrey35, size: 16)),
                errorBorder: outlineErrorBorder,
                enabledBorder: outlineBorder,
                focusedErrorBorder: outlineErrorBorder,
                focusedBorder: outlineBorder,
                border: outlineBorder)));
  }

  var outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey35.withOpacity(0.7)),
    borderRadius: BorderRadius.circular(5),
  );
  var outlineErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: colorSemanticRed100),
    borderRadius: BorderRadius.circular(5),
  );

  PreferredSizeWidget appbar() => appBarWidget(
      context: context,
      backgroundColor: colorBlack.withOpacity(0.8),
      titleStr: LocaleKeys.login.tr());

  @override
  int get tabIndex => ConstantKey.TAB_HOME;
}
