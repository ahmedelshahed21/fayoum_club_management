
class AddNewActivityRequestModel {

  final String title;
  final String description;
  final String money;
  final String moneyMember;

  AddNewActivityRequestModel({

    required this.title,
    required this.description,
    required this.money,
    required this.moneyMember,
  });

  Map<String, dynamic> toJson() {
    return {

      'title': title,
      'description': description,
      'mony': money,
      'monyMember': moneyMember,
    };
  }

  factory AddNewActivityRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewActivityRequestModel(
      title: json['title'],
      description: json['description'],
      money: json['mony'],
      moneyMember: json['monyMember'],
    );
  }
}
