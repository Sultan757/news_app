import 'dart:io';
import 'package:dio/dio.dart';
import 'package:showcase_app/models/response/response_wrapper.dart';
import 'package:showcase_app/utils/http_status_code.dart';

import '../../constant/app_strings.dart';

// const _defaultConnectTimeout = 60 * 1000;
// const _defaultReceiveTimeout = 60 * 1000;

class ApiClient {
  Dio? _dio;
  final List<Interceptor>? interceptors;

  ApiClient(Dio dio, {this.interceptors}) {
    _dio = dio;
    final customHeaders = <String, dynamic>{};
    customHeaders['Content-Type'] = 'application/json';
    customHeaders['Accept'] = 'application/json';

    _dio
      ?..options.baseUrl = AppStrings.baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 60 * 1000)
      ..options.receiveTimeout = const Duration(milliseconds: 60 * 1000)
      ..httpClientAdapter
      ..options.headers = customHeaders
      ..options.validateStatus = (int? status) {
        // Disable validation for specific status codes (e.g., 404)
        return status == null ||
            (status >= 200 && status < 300) ||
            status == 404;
      };
    if (interceptors?.isNotEmpty ?? false) {
      _dio?.interceptors.addAll(interceptors ?? []);
    }
  }

  ResponseWrapper _response(Response? response) {
    return ResponseWrapper(
      data: response?.data,
      message: "",
      statusCode: response?.statusCode,
    );
  }

  Future<ResponseWrapper<dynamic>> getReq(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      HttpStatusManager.handleStatusCode(_response(response));
      return _response(response); // Add this line to return the response
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseWrapper<dynamic>> postReq(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseWrapper<dynamic>> patchReq(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseWrapper<dynamic>> putReq(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio?.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseWrapper<dynamic>> deleteReq(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      var response = await _dio?.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
