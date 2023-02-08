import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String errorEmail;
  final String errorPass;
  final bool isShowPass;

  const LoginState(
      {this.errorEmail = "", this.errorPass = "", this.isShowPass = true});

  LoginState copyOf(
          {String? errorEmail, String? errorPass, bool? isShowPass}) =>
      LoginState(
          errorEmail: errorEmail ?? this.errorEmail,
          errorPass: errorPass ?? this.errorPass,
          isShowPass: isShowPass ?? this.isShowPass);

  @override
  List<Object?> get props => [errorEmail, errorPass, isShowPass];
}
