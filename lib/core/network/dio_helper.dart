import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:io';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // Accept all certificates (INSECURE, ONLY FOR TESTING)
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }}

// class MyHttpOverrides extends HttpOverrides {
//   final SecurityContext securityContext;
//
//   MyHttpOverrides(this.securityContext);
//
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(securityContext);
//   }
//
//   static Future<MyHttpOverrides> createWithCert() async {
//
//     final certBytes = await rootBundle.load('assets/cert/zeds-ips-all.crt');
//     final sc = SecurityContext(withTrustedRoots: true);
//     sc.setTrustedCertificatesBytes(certBytes.buffer.asUint8List());
//     return MyHttpOverrides(sc);
//   }
// }

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

  Future<dynamic> postDataWithoutToken(String parameter, dynamic data) async {
    try {
      final response = await dio.post<dynamic>('$api/$parameter',
          data: data,
          options: Options(
            contentType: 'application/json-patch+json',
            validateStatus: (state) => state! < 500,
          ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
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

  Future<dynamic> postDataWithOtherBaseUrl(String parameter,
      {dynamic data, Options? options}) async {
    try {
      final response = await dio.post<dynamic>('$parameter',
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

  Future<dynamic> patchData(String parameter, dynamic data,
      {Options? options}) async {
    try {
      final response = await dio.patch<dynamic>('$api$parameter',
          data: data,
          options: options ??
              Options(
                contentType: 'application/json',
                method: 'PATCH',
                validateStatus: (state) => state! < 500,
              ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> refreshTokenApi(
    String parameter,
    dynamic data,
  ) async {
    try {
      log('$api$parameter');
      final response = await Dio().post<dynamic>('$api$parameter',
          options: Options(
            contentType: 'application/json',
            method: 'POST',
            headers: data,
            validateStatus: (state) => state! < 500,
          ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> postWithParameters(
    String path,
    String parameter,
  ) async {
    try {
      log('$api/$path?$parameter');
      final response = await dio.post<dynamic>('$api/$path?$parameter',
          options: Options(
            contentType: 'application/json',
            method: 'POST',
            validateStatus: (state) => state! < 500,
          ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> putData(String parameter, Map<String, dynamic> data,
      {bool? isVersion1}) async {
    try {
      log('$api$parameter');
      log(data.toString());
      final response = await dio.put<dynamic>(
          "${(isVersion1 != null && !isVersion1) ? api.replaceAll("v1/", "") : api}$parameter",
          data: json.encoder.convert(data),
          options: Options(
            contentType: 'application/json',
            method: 'PUT',
            validateStatus: (state) => state! < 500,
          ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> delData(String parameter,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete<dynamic>('$api$parameter',
          data: data,
          options: Options(
            contentType: 'application/json',
            method: 'DEL',
            validateStatus: (state) => state! < 500,
          ));
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> getData(
      {required String url,
      String? token,
      bool? isVersion1,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get<dynamic>(
        "${(isVersion1 != null && !isVersion1) ? api.replaceAll("v1/", "") : api}$url",
        data: body != null ? body : null,
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: query != null ? query : null,
      );
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> getDataWithoutBaseurl({
    required String url,
    String? token,
    bool? isVersion1,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        '$url',
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> getDataWithQuery(
      {required String parameter,
      required Map<String, dynamic> query,
      String? token}) async {
    try {
      log('$api/$parameter');
      log(query.toString());
      final response = await dio.get<dynamic>(
        '$api$parameter',
        queryParameters: query,
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> uploadFiles({
    required String url,
    required List<File> files,
    required String keyImage,
    required String? key2,
    required dynamic val2,
    required String? key3,
    required dynamic val3,
    String? key4,
    List<dynamic>? val4,
    String? key5,
    dynamic val5,
    String? token,
  }) async {
    try {
      dio.options.headers = <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'language': 'en',
        'Authorization': 'Bearer $token',
      };
      log(url);

      List<MultipartFile> uploadList = <MultipartFile>[];
      for (File file in files) {
        MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
        uploadList.add(multipartFile);
      }

      FormData formData = FormData.fromMap(<String, dynamic>{
        keyImage: uploadList,
        if (key2 != null) key2: val2,
        if (key3 != null) key3: val3,
        if (key4 != null) key4: val4,
        if (key5 != null) key5: val5,
      });

      final response = await dio.post<dynamic>(
        "$api$url",
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (int? state) => state! < 500,
        ),
      );

      return handleResponse(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  bool isValidImageFormat(File file) {
    final List<String> supportedFormats = ['jpeg', 'jpg', 'png', 'tiff'];
    String extension =
        path.extension(file.path).toLowerCase().replaceFirst('.', '');
    return supportedFormats.contains(extension);
  }

  Future<dynamic> aiValidation({
    required String keyImage,
    required String url,
    required File file,
    required String? key2,
    required dynamic val2,
    required String? key3,
    required dynamic val3,
    String? token,
  }) async {
    try {
      final mimeType = lookupMimeType(file.path) ??
          'application/octet-stream'; // Get correct MIME type

      dio.options.headers = <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'language': 'en',
        'x-api-key': 'TVhJYt8W&J@je)yrhKuIxEvy%uaV(tfds',
        'Authorization': 'Bearer $token',
      };

      MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        contentType: MediaType.parse(mimeType), // Set correct content type
      );

      FormData formData = FormData.fromMap(<String, dynamic>{
        keyImage: multipartFile,
        if (key2 != null) key2: val2,
        if (key3 != null) key3: val3,
      });

      final response = await dio.post<dynamic>(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (int? state) => state! < 500,
        ),
      );

      return handleResponseAi(response);
    } on Exception catch (e) {
      log('Unexpected error: $e', error: e);
    }
  }

  Future<dynamic> verifyPersonalPhotoAi({
    required String url,
    required File selfieFile,
    required int overwrite, // 0 or 1
  }) async {
    try {
      // Read file as bytes and convert to base64
      final List<int> imageBytes = await selfieFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      // Prepare headers
      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-API-Key': 'W5tCbsGgRVm1XCxxrQCEatC9vhTNlgAaouw',
      };

      // Prepare JSON body
      final data = {
        'selfie': base64Image,
        'overwrite': overwrite,
      };

      // Send POST request
      final response = await dio.post<dynamic>(
        url,
        data: jsonEncode(data),
        options: Options(
          headers: headers,
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle response
      return response.data;
    } catch (e, stackTrace) {
      log('Error verifying personal photo', error: e, stackTrace: stackTrace);
      return null;
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

  dynamic handleResponseAi(Response response) {
    // debugPrint('test fares $response');
    //
    // if (response.statusCode.toString()[0] != '2') {
    //   if (response.statusCode == 401 || response.statusCode == 403) {
    //     navigateToPhoneVerificationScreenSafely();
    //     return;
    //   }
    //   throw DioError(
    //     response: response,
    //     requestOptions: response.requestOptions,
    //     type: DioErrorType.badResponse,
    //   );
    // }
    // if (response.headers.value('content-type')?.contains('text/html') ?? false) {
    //   try{
    //     debugPrint('test fares1 $response');
    //
    //     return jsonDecode(response.data.toString());
    //   }catch(e){
    //     return {'error': 'Unsupported content type', 'response': response.data};
    //
    //   }
    // }
    // debugPrint('test fares $response');
    return response.data;
  }

  // void navigateToPhoneVerificationScreenSafely() async {
  //   final context = AppRouter.globalNavKey.currentContext;
  //
  //   if (context != null && Navigator.of(context).mounted) {
  //     await context.read<HomeProvider>().logOutForExpire();
  //   } else {
  //     log('cant navigate');
  //   }
  // }

  Future<String> fetchModelFromNetwork() async {
    final url = 'https://zeds-storage-prod.s3.eu-west-1.amazonaws.com/we.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return jsonMap['we'] ??
            "zedsglobal.com"; // if the key 'we' is not found
      } else {
        return "zedsglobal.com"; // Return the default value if there is no network
      }
    } on SocketException {
      // Handle network connectivity issue
      return "zedsglobal.com"; // Return the default value if there is no network
    } catch (e) {
      // Catch other types of exceptions
      return "zedsglobal.com"; // Return the default value in case of other errors
    }
  }
}
