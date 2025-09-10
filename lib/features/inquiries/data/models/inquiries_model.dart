import 'package:fayoum_club_management/core/data/models/pagination_model.dart';
import 'package:fayoum_club_management/core/utils/end_points.dart';

class InquiriesModel {
  final List<InquiryItem> items;
  final PaginationModel? pagination;

  InquiriesModel({
    required this.items,
    this.pagination,
  });

  factory InquiriesModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKey.data];
    return InquiriesModel(
      items: (data?[ApiKey.items] as List<dynamic>?)
          ?.map((e) => InquiryItem.fromJson(e))
          .toList() ??
          [],
      pagination: data?[ApiKey.pagination] != null
          ? PaginationModel.fromJson(data[ApiKey.pagination])
          : null,
    );
  }
}

class InquiryItem {
  final int id;
  final String details;
  final String name;
  final String phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  InquiryItem({
    required this.id,
    required this.details,
    required this.name,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory InquiryItem.fromJson(Map<String, dynamic> json) {
    return InquiryItem(
      id: json[ApiKey.id] ?? 0,
      details: json[ApiKey.details] ?? '',
      name: json[ApiKey.name] ?? '',
      phone: json[ApiKey.phone] ?? '',
      createdAt: json[ApiKey.createdAt] != null
          ? DateTime.tryParse(json[ApiKey.createdAt])
          : null,
      updatedAt: json[ApiKey.updatedAt] != null
          ? DateTime.tryParse(json[ApiKey.updatedAt])
          : null,
    );
  }
}
