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

class Pagination {
  final int total;
  final int currentPage;
  final int perPage;
  final int totalPages;

  Pagination({
    required this.total,
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      currentPage: json['currentPage'],
      perPage: json['perPage'],
      totalPages: json['totalPages'],
    );
  }
}
