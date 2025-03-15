import 'package:coffee_house/service/APIResponse.dart';
import 'package:coffee_house/widget/custom_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://coffeehousee.site', // Đổi URL API của bạn
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Singleton Pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Thêm token (nếu cần)
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Xử lý response chung
  APIResponse handleResponse(Response response) {
    return APIResponse.fromJson(response.data);
  }

  // Xử lý lỗi chung
  APIResponse handleError(DioException error) {
    return APIResponse.fromJson(error.response?.data ?? error.response);
  }

  Future<APIResponse> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    } catch (e) {
      return APIResponse(
        status: 500,
        message: "Không thể kết nối đến server!",
        isSuccess: false,
        value: e.toString(),
      );
    }
  }

  Future<APIResponse> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  Future<APIResponse> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  Future<APIResponse> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  void ShowToastFromResponse(BuildContext context, APIResponse response) {
    if (response.isSuccess) {
      SuccessToast(
        context: context,
        message: response.message ?? "Success",
        duration: Duration(seconds: 2),
      ).ShowToast();
    } else {
      WarningToast(
        context: context,
        message: response.message ?? "Error",
        duration: Duration(seconds: 2),
      ).ShowToast();
    }
  }
}
