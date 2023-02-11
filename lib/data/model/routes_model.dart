// To parse this JSON data, do
//
//     final RoutesModel = RoutesModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_bloc/data/model/user_profile_model.dart';
import 'package:flutter/cupertino.dart';

List<RoutesModel> routeModelBySearchFromJson(List<dynamic> str) =>
    List<RoutesModel>.from(
        str.map((x) => RoutesModel.fromJson(x['_source']['after'])));

List<RoutesModel> routeModelFromJson(List<dynamic> str) =>
    List<RoutesModel>.from(str.map((x) => RoutesModel.fromJson(x)));

String routeModelToJson(List<RoutesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoutesModel {
  RoutesModel(
      {
      // this.modified,
      this.userGrade,
      this.hasConner,
      this.name,
      this.popurlarity,
      this.userId,
      this.published,
      this.userGradeCount,
      this.visibility,
      this.height,
      this.id,
      this.authorGrade,
      this.created,
      this.holds,
      this.isSelect = false,
      this.playlistIn,
      this.favouriteIn,
      this.userProfile,
      this.authorFirstName,
      this.authorLastName,
      this.isHighLight = false});

  // int? modified;
  int? userGrade;
  bool? hasConner;
  String? name;
  String? authorFirstName;
  String? authorLastName;
  int? popurlarity;
  int? userId;
  bool? published;
  int? userGradeCount;
  int? visibility;
  int? height;
  String? id;
  int? authorGrade;
  int? created;
  String? holds;
  bool isSelect;
  bool? playlistIn;
  bool? favouriteIn;
  UserProfileModel? userProfile;
  bool isHighLight;

  RoutesModel copyOf(
          {int? userGrade,
          bool? hasConner,
          String? name,
          String? authorFirstName,
          String? authorLastName,
          int? popurlarity,
          int? userId,
          bool? published,
          int? userGradeCount,
          int? visibility,
          int? height,
          String? id,
          int? authorGrade,
          int? created,
          String? holds,
          bool? isSelect,
          bool? playlistIn,
          bool? favouriteIn,
          UserProfileModel? userProfile,
          bool? isHighLight}) =>
      RoutesModel(
          userGrade: userGrade ?? this.userGrade,
          hasConner: hasConner ?? this.hasConner,
          name: name ?? this.name,
          authorFirstName: authorFirstName ?? this.authorFirstName,
          authorLastName: authorLastName ?? this.authorLastName,
          popurlarity: popurlarity ?? this.popurlarity,
          userId: userId ?? this.userId,
          published: published ?? this.published,
          userGradeCount: userGradeCount ?? this.userGradeCount,
          visibility: visibility ?? this.visibility,
          height: height ?? this.height,
          id: id ?? this.id,
          authorGrade: authorGrade ?? this.authorGrade,
          created: created ?? this.created,
          holds: holds ?? this.holds,
          isSelect: isSelect ?? this.isSelect,
          playlistIn: playlistIn ?? this.playlistIn,
          favouriteIn: favouriteIn ?? this.favouriteIn,
          userProfile: userProfile ?? this.userProfile,
          isHighLight: isHighLight ?? this.isHighLight);

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
      // modified: json["modified"],
      userGrade: json["user_grade"].toInt(),
      hasConner: json["has_conner"],
      name: json["name"],
      popurlarity: json["popurlarity"],
      userId: json["user_id"],
      published: json["published"],
      userGradeCount: json["user_grade_count"].toInt(),
      visibility: json["visibility"],
      height: json["height"],
      id: json["id"],
      authorGrade: json["author_grade"].toInt(),
      created: json["created"],
      holds: json["holds"].toString(),
      isSelect: false,
      playlistIn: json["playlist_in"],
      authorLastName: json["author_last_name"],
      authorFirstName: json["author_first_name"],
      favouriteIn: json["favourite_in"],
      userProfile: json["user_profile"] != null
          ? UserProfileModel.fromJson(json["user_profile"])
          : null);

  Map<String, dynamic> toJson() => {
        // "modified": modified,
        "user_grade": userGrade,
        "has_conner": hasConner,
        "name": name,
        "popurlarity": popurlarity,
        "user_id": userId,
        "published": published,
        "user_grade_count": userGradeCount,
        "visibility": visibility,
        "height": height,
        "id": id,
        "author_grade": authorGrade,
        "created": created,
        "holds": holds,
        "playlist_in": playlistIn,
        "favourite_in": favouriteIn,
      };
}
