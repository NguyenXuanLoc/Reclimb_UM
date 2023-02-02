import '../../config/constant.dart';

class DeviceModel {
  final String deviceId;
  final String deviceModel;
  final String deviceName;
  final String accessToken;
  final String userId;

  DeviceModel(
      this.deviceId, this.deviceModel, this.deviceName, this.accessToken, this.userId);

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
      json[ApiKey.device_id],
      json[ApiKey.device_model],
      json[ApiKey.device_name],
      json[ApiKey.token],
      json[ApiKey.user_id]);

  Map<String, Object?> toJson() {
    return <String, Object?>{
      ApiKey.device_id: deviceId,
      ApiKey.device_model: deviceModel,
      ApiKey.device_name: deviceName,
      ApiKey.token: accessToken,
      ApiKey.user_id: userId,
    };
  }
}
