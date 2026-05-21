import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';


// REMOVED: MyHttpOverrides with badCertificateCallback = true was a critical
// security vulnerability allowing MITM attacks. SSL is now validated normally.

class DioHelper {
  static late Dio dio;

  static String api = APIEndpoints.baseUrl;

  static Future<void> initialize() async {
    dio = Dio(
      BaseOptions(
        followRedirects: true,
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        receiveDataWhenStatusError: true,
        validateStatus: (int? state) => state! < 500,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) =>
                onRequestHandler(options, handler),
        onError: (DioException error, ErrorInterceptorHandler handler) {
          handler.next(error);
        },
      ),
      // SECURITY FIX: Logging is now restricted to debug builds only.
      // Full request/response logging in production leaks tokens and PII.
      if (kDebugMode)
        LogInterceptor(
          responseBody: true,
          error: true,
          requestBody: true,
          requestHeader: true,
        ),
    ]);
  }

  static void onRequestHandler(
      RequestOptions req, RequestInterceptorHandler handler) async {
    final token =
        AppSharedPreferences.getString(SharedPreferencesKeys.accessToken);
    final uuid =
        AppSharedPreferences.getString(SharedPreferencesKeys.uuid);
    if (kDebugMode) log('${token.toString()} token');
    if (token != null && token.isNotEmpty) {
      req.headers['Authorization'] = 'Bearer $token';
    }
    req.headers['Content-Type'] = 'application/json';
    if (uuid != null && uuid.isNotEmpty) {
      req.headers['X-Device-UUID'] = uuid;
    }
    handler.next(req);
  }

  Future<dynamic> postData(String parameter, dynamic data,
      {Options? options, bool? isVersion1}) async {
    try {
      final response = await dio.post<dynamic>(
          "${(isVersion1 != null && !isVersion1) ? api.replaceAll("v1/", "") : api}$parameter",
          data: data,
          options: options ??
              Options(
                contentType: 'application/json',
                method: 'POST',
                validateStatus: (state) => state! < 500,
              ));
      return handleResponse(response);
    } on Exception catch (e) {
      if (kDebugMode) log('Unexpected error: $e', error: e);
    }
  }

  dynamic handleResponse(Response response) {
    if (response.statusCode.toString()[0] != '2') {
      throw DioException(
        response: response,
        requestOptions: response.requestOptions,
        type: DioExceptionType.badResponse,
      );
    }
    if (response.headers.value('content-type')?.contains('text/html') ??
        false) {
      try {
        return jsonDecode(response.data.toString());
      } catch (e) {
        return {'error': 'Unsupported content type', 'response': response.data};
      }
    }
    return response.data;
  }
}
