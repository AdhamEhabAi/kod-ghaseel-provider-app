import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // Accept all certificates (INSECURE, ONLY FOR TESTING)
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }}


class DioHelper {
  static late Dio dio;

  static String api = APIEndpoints.baseUrl;

  static Future<void> initialize() async {
    // final certBytes = await rootBundle.load('assets/cert/zeds-ips-all.crt');
    //
    // // Create SecurityContext and add your certificate
    // SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    // securityContext.setTrustedCertificatesBytes(certBytes.buffer.asUint8List());

    // Create a HttpClient with this context

    // Create a Dio HttpClientAdapter that uses this HttpClient
    // final ioAdapter = IOHttpClientAdapter();
    // ioAdapter.createHttpClient = () {
    //
    //   final client = HttpClient(context: securityContext);
    //
    //   // Optional: trust all certificates, use carefully
    //
    //   return client;
    // };
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
    // dio.httpClientAdapter = ioAdapter;

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) =>
                onRequestHandler(options, handler),
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // if (error.response?.statusCode == 401 ||
          //     error.response?.statusCode == 403) {
          //   if (AppRouter.globalNavKey.currentContext != null) {
          //     GoRouter.of(AppRouter.globalNavKey.currentContext!)
          //         .go(AppRouter.phoneVerificationScreen);
          //   } else {
          //     log('Navigation context is null. Cannot navigate to phoneVerificationScreen.');
          //   }
          //   return;
          // }
          handler.next(error);
        },
      ),
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
    log(token.toString() + ' token');
    if (token != null && token.isNotEmpty) {
      req.headers['Authorization'] = 'Bearer $token';
    }
    req.headers['Content-Type'] = 'application/json';
    if (uuid != null && uuid.isNotEmpty) {
      req.headers['X-Device-UUID'] = '$uuid';
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
      log('Unexpected error: $e', error: e);
    }
  }


  dynamic handleResponse(Response response) {
    if (response.statusCode.toString()[0] != '2') {
      // if (response.statusCode == 401 || response.statusCode == 403) {
      //   navigateToPhoneVerificationScreenSafely();
      //   return;
      // }
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
