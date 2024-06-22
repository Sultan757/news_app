import 'package:dio/dio.dart';
import 'package:showcase_app/models/response/get_comments.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/models/response/register_response.dart';
import '../../models/response/post_comment_response.dart';
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

  Future<GetCommentsResponse> getComments(String id) async {
    final response = await _apiClient.getReq(
      '/comments/$id',
    );
    return GetCommentsResponse.fromJson(response.data);
  }

  Future<postCommentResponse> postComment(
      String id,
      String author,
      String commentContent,
      ) async {
    final response = await _apiClient.postReq(
      '/comments/$id',
      data: {

        'author': author,
        'content': commentContent
        
      },
    );
    return postCommentResponse.fromJson(response.data);


}
}
