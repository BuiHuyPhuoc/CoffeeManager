import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class APIResponse {
  final int status;
  final String? message;
  final bool isSuccess;
  final dynamic value;
  APIResponse({
    required this.status,
    this.message,
    required this.isSuccess,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'isSuccess': isSuccess,
      'value': value,
    };
  }

  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse(
      status: map['status'] as int,
      message: map['message'] != null ? map['message'] as String : null,
      isSuccess: map['isSuccess'] as bool,
      value: map['value'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  // Kiểm tra và parse JSON
  factory APIResponse.fromJson(dynamic responseBody) {
    if (responseBody is Map<String, dynamic>) {
      if (responseBody.containsKey("status") &&
          responseBody.containsKey("isSuccess")) {
        return APIResponse(
          status: responseBody["status"] ?? 0,
          message: responseBody["message"],
          isSuccess: responseBody["isSuccess"],
          value: responseBody["value"],
        );
      } else {
        return APIResponse(
          status: responseBody["status"] ?? 0,
          message: responseBody["message"],
          isSuccess: false,
          value: responseBody,
        );
      }
    }

    return APIResponse(
      status: 500,
      message: "Lỗi",
      isSuccess: false,
      value: responseBody,
    );
  }
}
