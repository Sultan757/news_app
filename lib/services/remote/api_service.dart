import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/models/response/register_response.dart';
import 'api_client.dart';

class ApiService {
  late ApiClient _apiClient;

  ApiService() {
    var dio = Dio();
    _apiClient = ApiClient(dio);
  }

  Future<dynamic> getMockData() async {
    final response = await _apiClient.getReq('/');
    return null;
  }

  //register user
  Future<RegisterResponse> register(
      String email,
      String password,
      ) async {
    final response = await _apiClient.postReq(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
      },
    );
    return RegisterResponse.fromJson(response.data);
  }

  Future<LoginResponse> login(
      String email,
      String password,
      ) async {
    final response = await _apiClient.postReq(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<GetNewsResponse> getNews() async {
    final response = await _apiClient.getReq(
      '/news/get-news',
    );
    return GetNewsResponse.fromJson(response.data);
  }


}
