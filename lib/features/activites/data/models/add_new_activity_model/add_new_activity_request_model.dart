import 'package:fayoum_club_management/core/utils/end_points.dart';


class AddNewActivityRequestModel {
  final String title;
  final String description;
  final String money;
  final String moneyMember;
  final String type;

  AddNewActivityRequestModel({
    required this.title,
    required this.description,
    required this.money,
    required this.moneyMember,
    required this.type
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.money: money,
      ApiKey.moneyMember: moneyMember,
      ApiKey.type:type
    };
  }

  factory AddNewActivityRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewActivityRequestModel(
      title: json[ApiKey.title],
      description: json[ApiKey.description],
      money: json[ApiKey.money],
      moneyMember: json[ApiKey.moneyMember],
      type: json[ApiKey.type],
    );
  }
}
