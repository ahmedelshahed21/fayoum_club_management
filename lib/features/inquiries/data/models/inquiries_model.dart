import 'package:fayoum_club_management/core/data/models/pagination_model.dart';

class InquiriesModel {
  final List<InquiryItem> items;
  final Pagination pagination;

  InquiriesModel({
    required this.items,
    required this.pagination,
  });

  factory InquiriesModel.fromJson(Map<String, dynamic> json) {
    return InquiriesModel(
      items: (json['data']['items'] as List)
          .map((e) => InquiryItem.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['data']['pagination']),
    );
  }
}

class InquiryItem {
  final int id;
  final String details;
  final String name;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  InquiryItem({
    required this.id,
    required this.details,
    required this.name,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InquiryItem.fromJson(Map<String, dynamic> json) {
    return InquiryItem(
      id: json['id'],
      details: json['details'],
      name: json['name'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}


