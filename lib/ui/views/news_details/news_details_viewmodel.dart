import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/models/response/get_comments.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/models/response/register_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/services/remote/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsDetailsViewModel extends BaseViewModel {
  RegisterUser? retrieveUserDetails;
  LoginData? retrieveLoginUserDetails;
  TextEditingController postCommentController = TextEditingController();

  ApiService apiService = locator<ApiService>();
  List<String> commentsList = [];
  List<String> authorList = [];
  bool isLoading = false;

  Future<void> saveCommentsAndAuthors(String blogId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final commentsKey = 'comments_$blogId';
    final authorsKey = 'authors_$blogId';

    await prefs.setStringList(commentsKey, commentsList);
    await prefs.setStringList(authorsKey, authorList);
  }

  Future<void> loadCommentsAndAuthors(String blogId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final commentsKey = 'comments_$blogId';
    final authorsKey = 'authors_$blogId';

    commentsList = prefs.getStringList(commentsKey) ?? [];
    authorList = prefs.getStringList(authorsKey) ?? [];
    notifyListeners();
  }

  // Get comments API
  Future<void> getComments(String id) async {
    try {
      final response = await apiService.getComments(id);

      if (response.status == 200) {
        commentsList.clear();
        authorList.clear();
        response.comments?.forEach((element) {
          commentsList.add(element.content!);
          authorList.add(element.author!);
        });

        await saveCommentsAndAuthors(id);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> postComment(String blogId) async {
    String? username = await SharedPreferencesHelper.getString('username');
    final response = await apiService.postComment(
      blogId,
      username!,
      postCommentController.text,
    );

    if (response != null) {
      // Add the new comment to the local list and notify listeners
      commentsList.add(postCommentController.text);
      authorList.add(username);

      await saveCommentsAndAuthors(blogId);
      postCommentController.clear();
      notifyListeners();

      NavService.showSnackBar('Success!', 'Your comment added', const Duration(milliseconds: 2000));

      // Refresh the comments list
      await getComments(blogId);
    } else {
      NavService.showSnackBar("Failure", "Comment not posted", const Duration(milliseconds: 2000));
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> onInit(String blogId) async {
    await getComments(blogId);
    final LoginData? loginPayload = await SharedPreferencesHelper.getObject<LoginData>(
      'loginPayload',
          (data) => LoginData.fromJson(data),
    );
    retrieveLoginUserDetails = loginPayload;

    final RegisterUser? registerPayload = await SharedPreferencesHelper.getObject<RegisterUser>(
      'registerPayload',
          (data) => RegisterUser.fromJson(data),
    );
    retrieveUserDetails = registerPayload;

    await loadCommentsAndAuthors(blogId);
  }
}
