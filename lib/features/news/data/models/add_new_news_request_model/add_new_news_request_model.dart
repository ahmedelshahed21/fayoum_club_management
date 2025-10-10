
import 'package:fayoum_club_management/core/utils/end_points.dart';

class AddNewNewsRequestModel {

  final String title;
  final String description;
  final String? activityId;
  final int status;
  final String? typeOption;

  AddNewNewsRequestModel({

    required this.title,
    required this.description,
     this.activityId,
    required this.status,
     this.typeOption,
  });

  Map<String, dynamic> toJson() {
    return {

      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.activityId:activityId,
      ApiKey.status: status,
      ApiKey.typeOption: typeOption,
    };
  }

  factory AddNewNewsRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewNewsRequestModel(
      title: json[ApiKey.title],
      description: json[ApiKey.description],
      activityId:  json[ApiKey.activityId],
      status: json[ApiKey.status],
      typeOption: json[ApiKey.typeOption],
    );
  }
}
