import 'package:fayoum_club_management/core/data/models/pagination_model.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';

class UsersModel {
  final int version;
  final int code;
  final String status;
  final String? message;
  final UsersData data;

  UsersModel({
    required this.version,
    required this.code,
    required this.status,
    this.message,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      version: json[ApiKey.version],
      code: json[ApiKey.code],
      status: json[ApiKey.status],
      message: json[ApiKey.message],
      data: UsersData.fromJson(json[ApiKey.data]),
    );
  }
}

class UsersData {
  final List<UserItem> items;
  final PaginationModel pagination;

  UsersData({
    required this.items,
    required this.pagination,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) {
    return UsersData(
      items: List<UserItem>.from(
        json[ApiKey.items].map((e) => UserItem.fromJson(e)),
      ),
      pagination: PaginationModel.fromJson(json[ApiKey.pagination]),
    );
  }
}

class UserItem {
  final int id;
  final String name;
  final String phone;
  final int isActive;
  final String? code;
  final int isMember;
  final String email;
  final String gender;
  final String createdAt;
  final String updatedAt;

  UserItem({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    this.code,
    required this.isMember,
    required this.email,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      phone: json[ApiKey.phone],
      isActive: json[ApiKey.isActive],
      code: json[ApiKey.code],
      isMember: json[ApiKey.isMember],
      email: json[ApiKey.email],
      gender: json[ApiKey.gender],
      createdAt: json[ApiKey.createdAt],
      updatedAt: json[ApiKey.updatedAt],
    );
  }
}



