import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/home/home_cubit.dart';
import 'package:base_bloc/modules/home/home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _bloc;

  @override
  void initState() {
    _bloc = HomeCubit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
        bloc: _bloc,
        listener: (BuildContext context, state) {
          if (state.type == StatusType.showDialog) {
            _bloc.showConnectDevice(context);
          }
        },
        child: AppScaffold(
            fullStatusBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
              alignment: Alignment.center,
              child: InkWell(
                  child: AppText("AAAA",
                      style: typoW400.copyWith(color: colorText0)),
                  onTap: () => _bloc.sentData()),
            )));
  }
}
