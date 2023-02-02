import 'package:equatable/equatable.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

enum StatusType { Init, ScanSuccess }

class PairingState extends Equatable {
  final StatusType type;
  final List<Device> lDevice;

  const PairingState({this.type = StatusType.Init, this.lDevice = const []});

  @override
  List<Object?> get props => [];
}
