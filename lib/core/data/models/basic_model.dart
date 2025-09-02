class BasicModel {
  final int version;
  final int code;
  final String status;
  final String? message;
  final dynamic data;

  BasicModel({
    required this.version,
   required this.code,
    required this.status,
    this.message,
    this.data,
  });

  factory BasicModel.fromJson(Map<String, dynamic> json) {
    return BasicModel(
      version: json['version'] as int,
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'code': code,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
