import '../../config/constant.dart';

enum ActionType { Loading }

extension ActionTypeExtension on ActionType {
  String get type {
    switch (this) {
      case ActionType.Loading:
        return ApiKey.loading;
    }
  }
}

enum NearbyType { Login }

extension NearbyTypeeExtension on NearbyType {
  String get type {
    switch (this) {
      case NearbyType.Login:
        return ApiKey.loading;
    }
  }
}
