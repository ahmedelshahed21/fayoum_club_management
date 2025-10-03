import 'package:fayoum_club_management/core/utils/end_points.dart';

class AddNewTrainerRequestModel {
  final int activityId;
  final String name;
  final String description;
  final int isActive;
  final List<TrainerTime> times;

  AddNewTrainerRequestModel({
    required this.activityId,
    required this.name,
    required this.description,
    required this.isActive,
    required this.times,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      ApiKey.name: name,
      ApiKey.description: description,
      ApiKey.isActive: isActive,
      ApiKey.activityId: activityId,
    };

    for (int i = 0; i < times.length; i++) {
      json['time[$i][day]'] = times[i].day;
      json['time[$i][from_time]'] = times[i].fromTime;
      json['time[$i][to_time]'] = times[i].toTime;
    }

    return json;
  }

  factory AddNewTrainerRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewTrainerRequestModel(
      activityId: json[ApiKey.activityId],
      name: json[ApiKey.name],
      description: json[ApiKey.description],
      isActive: json[ApiKey.isActive],
      times: [],
    );
  }
}

class TrainerTime {
  final String day;
  final String fromTime;
  final String toTime;

  TrainerTime({
    required this.day,
    required this.fromTime,
    required this.toTime,
  });
}
