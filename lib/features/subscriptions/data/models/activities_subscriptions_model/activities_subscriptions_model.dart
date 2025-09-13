import 'package:fayoum_club_management/core/data/models/activity_model.dart';
import 'package:fayoum_club_management/core/data/models/pagination_model.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';

class ActivitiesSubscriptionsModel {
  final List<ActivitySubscriptionItem> items;
  final PaginationModel? pagination;

  ActivitiesSubscriptionsModel({
    required this.items,
    this.pagination,
  });

  factory ActivitiesSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKey.data];
    return ActivitiesSubscriptionsModel(
      items: (data[ApiKey.items] as List<dynamic>)
          .map((e) => ActivitySubscriptionItem.fromJson(e))
          .toList(),
      pagination: data[ApiKey.pagination] != null
          ? PaginationModel.fromJson(data[ApiKey.pagination])
          : null,
    );
  }
}

class ActivitySubscriptionItem {
  final int id;
  final int userId;
  final int activityId;
  final User user;
  final ActivityModel activity;
  final int moneyPay;
  final String numberCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ActivitySubscriptionItem({
    required this.id,
    required this.userId,
    required this.activityId,
    required this.user,
    required this.activity,
    required this.moneyPay,
    required this.numberCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ActivitySubscriptionItem.fromJson(Map<String, dynamic> json) {
    return ActivitySubscriptionItem(
      id: json["id"] ?? 0,
      userId: json["userId"] ?? 0,
      activityId: json["activiteId"] ?? 0, // 👈 لاحظ التسمية
      user: User.fromJson(json["user"]),
      activity: ActivityModel.fromJson(json["activite"]), // 👈 لاحظ التسمية
      moneyPay: json["monyPay"] is int
          ? json["monyPay"]
          : int.tryParse(json["monyPay"].toString()) ?? 0,
      numberCode: json["numberCode"]?.toString() ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }
}



class User {
  final int id;
  final String email;
  final String phone;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      phone: json[ApiKey.phone],
      name: json[ApiKey.name],
    );
  }
}
