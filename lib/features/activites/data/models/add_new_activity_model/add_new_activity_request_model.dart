import 'package:fayoum_club_management/core/constants/end_points.dart';

class AddNewActivityRequestModel {
  final String title;
  final String phoneNumber;
  final String email;
  final String password;
  final int isMember;
  final String? code;
  final String gender;

  AddNewActivityRequestModel({
    required this.title,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.isMember,
    this.code,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      ApiKey.phoneNumber: phoneNumber,
      ApiKey.email: email,
      ApiKey.password: password,
      ApiKey.isMember: isMember,
      ApiKey.code: code,
      ApiKey.gender: gender,
    };
  }

  factory AddNewActivityRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewActivityRequestModel(
      title: json['title'],
      phoneNumber: json[ApiKey.phoneNumber],
      email: json[ApiKey.email],
      password: json[ApiKey.password],
      isMember:  json[ApiKey.isMember],
      code: json[ApiKey.code],
      gender: json[ApiKey.gender],
    );
  }
}
