import 'package:base_bloc/data/nearby/nearby_ext.dart';

class NearbyData {
  final NearbyType nearbyType;
  final ActionType? actionType;
  final dynamic data;

  NearbyData({required this.nearbyType, this.actionType, required this.data});

  Map<String, dynamic> toJson() => {
        "nearbyType": nearbyType.type.toString(),
        "actionType": actionType != null ? actionType!.type : '',
        "data": data
      };

  factory NearbyData.fromJson(Map<String, dynamic> json) => NearbyData(
      nearbyType: json['nearbyType'],
      actionType: json['actionType'],
      data: json['data']);
}
