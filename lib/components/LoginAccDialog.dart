import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/info_user_model.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginAccountDialog extends StatefulWidget {
  final UserInfoModel model;

  const LoginAccountDialog({Key? key, required this.model}) : super(key: key);

  @override
  State<LoginAccountDialog> createState() => _LoginAccountDialogState();
}

class _LoginAccountDialogState extends State<LoginAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(contentPadding),
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(maxHeight: 200, minHeight: 200),
      decoration: BoxDecoration(
          color: colorWhite, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          AppText(
            "Please input password for acc:\n${widget.model.userName}",
            style: typoW500.copyWith(color: colorText100),
            textAlign: TextAlign.center,
          ),
          AppTextField(
              decoration: decorTextField.copyWith(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  suffixIcon: const Icon(Icons.remove_red_eye)))
        ],
      ),
    );
  }
}
