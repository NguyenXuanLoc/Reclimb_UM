import 'dart:async';

import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/dialogs.dart';
import '../../localization/locale_keys.dart';
import '../../utils/app_utils.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void showPass() => emit(state.copyOf(isShowPass: !state.isShowPass));

  void loginOnclick(TextEditingController emailController,
      TextEditingController passController, BuildContext context) {
    if (isValid(emailController, passController)) {
      Dialogs.showLoadingDialog(context);
      Timer(const Duration(seconds: 2), () async {
        await Dialogs.hideLoadingDialog();
        Utils.hideKeyboard(context);
        RouterUtils.pop(context);
      });
    }
  }

  bool isValid(TextEditingController emailController,
      TextEditingController passController) {
    var email = emailController.text.replaceAll(' ', '');
    emailController.text = email;
    var pass = passController.value.text;
    bool isValid = true;
    if (email.isEmpty) {
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_email.tr()));
      isValid = false;
    } else if (!EmailValidator.validate(email) ||
        Utils.checkDiacriticsForEmail(email)) {
      isValid = false;
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_valid_email.tr()));
    } else {
      logE("TAG OK");
      emit(state.copyOf(errorEmail: ""));
    }
    if (pass.isEmpty) {
      isValid = false;
      emit(state.copyOf(errorPass: LocaleKeys.please_input_pass.tr()));
    } else if (pass.length < 8 || !Utils.validatePassword(pass)) {
      isValid = false;
      emit(state.copyOf(errorPass: LocaleKeys.please_input_valid_pass.tr()));
    } else {
      emit(state.copyOf(errorPass: ""));
    }
    return isValid;
  }
}
