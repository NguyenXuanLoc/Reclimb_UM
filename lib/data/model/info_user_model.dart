class UserInfoModel {
  final String avatar;
  final String userName;
  final bool isLogin;
  bool isHighlight;

  UserInfoModel(this.avatar, this.userName, this.isLogin, this.isHighlight);

  UserInfoModel copyOf(
          {String? avatar,
          String? userName,
          bool? isLogin,
          bool? isHighlight}) =>
      UserInfoModel(avatar ?? this.avatar, userName ?? this.userName,
          isLogin ?? this.isLogin, isHighlight ?? this.isHighlight);
}
