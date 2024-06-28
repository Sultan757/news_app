import 'package:dio/dio.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/remote/api_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  ApiService apiService = locator<ApiService>();
  GetNewsResponse? getNewsResponse;
  List<String> imgUrl = [];
  List<dynamic> imgObject = [];
  List<String> description = [];
  List<Data>? myData = [];
  List<String> imgTitle = [];
  List<String> blogId = [];
  List<List<String>> videoUrls = []; // List of lists to store video URLs for each article

  bool isLoading = false;
  String? _existingImage;
  String? get existingImage => _existingImage;

  // Future<void> loadUserData() async {
  //   _existingImage = await SharedPreferencesHelper.getString('profile');
  //
  //
  //   notifyListeners();
  // }
  //get news api
  Future<GetNewsResponse> getNews() async {
    final response = await apiService.getNews();

    try {
      if (response.status == 200) {
        _existingImage = await SharedPreferencesHelper.getString('profile');
        notifyListeners();

        myData = response.data;
        isLoading = false;
        response.data.forEach((element) {
          description.add(element.description);
          blogId.add(element.id);
          imgUrl.add(element.image.isNotEmpty ? element.image[0].url : '');
          imgTitle.add(element.title);
          imgObject = element.image;

          // Extract video URLs
          List<String> videos = [];
          element.myvideo.forEach((videoElement) {
            videos.add(videoElement.url);
          });
          videoUrls.add(videos);
        });

        notifyListeners();
      }
    } on DioException catch (e) {
      print(e);
    }

    return response;
  }

  onInit() async {
    getNews();
    isLoading = true;
  }
}
