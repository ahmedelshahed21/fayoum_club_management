import 'package:fayoum_club_management/core/utils/end_points.dart';


class SuccessModel {
  final int version;
  final int code;
  final String status;
  final String? message;
  final dynamic data;

  SuccessModel({
    required this.version,
    required this.code,
    required this.status,
    this.message,
    this.data,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      version: json[ApiKey.version] as int,
      code: json[ApiKey.code] as int,
      status: json[ApiKey.status] as String,
      message: json[ApiKey.message] as String?,
      data: json[ApiKey.data],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.version: version,
      ApiKey.code: code,
      ApiKey.status: status,
      ApiKey.message: message,
      ApiKey.data: data,
    };
  }
}


