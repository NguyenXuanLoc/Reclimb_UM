import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

enum StatusType { init, showDialog }

class HomeState extends Equatable {
  final StatusType type;
  final List<Device> lDevice;

  const HomeState({this.type = StatusType.init, this.lDevice = const []});

  @override
  List<Object?> get props => [StatusType.init, lDevice];
}
