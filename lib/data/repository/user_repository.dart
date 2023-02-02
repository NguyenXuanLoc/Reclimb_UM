import 'dart:convert';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/repository/base_service.dart';
import '../globals.dart' as globals;
import 'api_result.dart';

class UserRepository extends BaseService {
  static UserRepository instance = UserRepository._init();

  factory UserRepository() {
    return instance;
  }

  UserRepository._init() {
    initProvider();
  }

  Future<ApiResult> login(String email, String pass) async =>
      await POST('auth/login', {
        ApiKey.email: email,
        ApiKey.password: pass,
        ApiKey.device_id: globals.deviceId,
        ApiKey.device_name: globals.deviceName,
        ApiKey.device_model: globals.deviceModel,
      });

  Future<ApiResult> createPlaylist(String name, int userId) async =>
      await POST('playlist', {ApiKey.name: '', ApiKey.user_id: userId});

  Future<ApiResult> getPlaylists() async =>
      await GET('playlist?start=1&count=${ApiKey.limit_offset}');

  Future<ApiResult> getPlaylistById(String id, {int nextPage = 0}) async =>
      await GET('playlist/$id?start=$nextPage&count=${ApiKey.limit_offset}');

  Future<ApiResult> getRoute({int nextPage = 0}) async =>
      await GET('route?start=$nextPage&count=100000');

  Future<ApiResult> deleteRoute(String routeId) async =>
      await DELETE('route/$routeId');

  Future<ApiResult> addToPlaylist(
          String playlistId, List<String> lRoute) async =>
      await POST('playlistdetail/$playlistId', {ApiKey.route_ids: lRoute});

  Future<ApiResult> removeFromPlaylist(
          String playlistId, String routeId) async =>
      await DELETE('playlistdetail/$playlistId?ids=$routeId');

  Future<ApiResult> moveToTop(String playlistId, String routeId) async =>
      await PUT('playlistdetail/$playlistId', body: {ApiKey.route_id: routeId});

  Future<ApiResult> dragAndDrop(
          String playlistId, String endId, List<String> listId) async =>
      await PUT("playlistdetail/$playlistId",
          body: {ApiKey.border: endId, ApiKey.route_ids: listId});

  Future<ApiResult> getRouteDetail(String routeId) async =>
      GET('route/$routeId');

  Future<ApiResult> getRouteDetailAno(String routeId) async =>
      GET('route/public/$routeId');

  Future<ApiResult> getUserProfile(int userId, {String? accessToken}) async =>
      await GET('kuser/profile/$userId', accessToken: accessToken);

  Future<ApiResult> getAllHoldSet() async =>
      await GET('hold?start=1&count=100');

  Future<ApiResult> getRouteForUserLoginWall(String token) async =>
      await GET('favourite?start=1&count=5', accessToken: token);
}
