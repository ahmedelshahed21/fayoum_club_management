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

  // Add hasNext getter
  bool get hasNext => currentPage < totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      currentPage: json['currentPage'],
      perPage: json['perPage'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "currentPage": currentPage,
      "perPage": perPage,
      "totalPages": totalPages,
    };
  }
}