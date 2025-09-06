
class AddNewNewsRequestModel {

  final String title;
  final String description;
  final String activityId;
  final int status;
  final String? typeOption;

  AddNewNewsRequestModel({

    required this.title,
    required this.description,
    required this.activityId,
    required this.status,
     this.typeOption,
  });

  Map<String, dynamic> toJson() {
    return {

      'title': title,
      'description': description,
      'activateId':activityId,
      'status': status,
      'typeOption': typeOption,
    };
  }

  factory AddNewNewsRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewNewsRequestModel(
      title: json['title'],
      description: json['description'],
      activityId:  json['activateId'],
      status: json['status'],
      typeOption: json['typeOption'],
    );
  }
}
