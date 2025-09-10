import 'package:fayoum_club_management/core/utils/end_points.dart';

class AddNewTrainerRequestModel {
  final int activityId;
  final String name;
  final String description;
  final int isActive;

  AddNewTrainerRequestModel({
    required this.activityId,
    required this.name,
    required this.description,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.description: description,
      ApiKey.isActive: isActive,
      ApiKey.activityId:activityId
    };
  }

  factory AddNewTrainerRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewTrainerRequestModel(
      activityId: json[ApiKey.activityId],
      name: json[ApiKey.name],
      description: json[ApiKey.description],
      isActive: json[ApiKey.isActive],
    );
  }
}
