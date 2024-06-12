import 'package:dio/dio.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/models/response/get_news_response.dart';
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

  //
  bool isLoading = false;


  //get news api
  Future<GetNewsResponse> getNews() async {
    final response = await apiService.getNews();

    try {
      if (response.status == 200) {
        myData = response.data;
        isLoading = false;
        response.data.forEach((element) {
          description.add(element.description);
          imgUrl.add(element.image[0].url);
          print('image====${imgUrl}');
          //    blogId.add(element.sId!);

          imgTitle.add(element.title);


          imgObject = element.image;
        });

        notifyListeners();
      }
    } on DioException catch (e) {
      print(e);
    }

    return response;
  }

  // //get article count
  // int? articleCount;
  // String? isVerified;
  //
  //
  // FinalUser? retrieveUserDetails;
  // LoginData? retrieveLoginUserDetails;
  // String? registerToken;
  // String? loginToken;
  //
  onInit() async {
    getNews();
    isLoading = true;
    // register object retrieve
    // final LoginData? consumerPayload =
    // await SharedPreferencesHelper.getObject<LoginData>(
    //   'userPayload',
    //       (data) => LoginData.fromJson(data),
    // );
    //
    //   retrieveLoginUserDetails = consumerPayload;
    //
    //   final FinalUser? registerPayload =
    //   await SharedPreferencesHelper.getObject<FinalUser>(
    //     'registerPayload',
    //         (data) => FinalUser.fromJson(data),
    //   );
    //   retrieveUserDetails = registerPayload;
    //
    //   String? login = await SharedPreferencesHelper.getString('loginToken');
    //   loginToken = login;
    //
    //   String? register = await SharedPreferencesHelper.getString('registerToken');
    //   registerToken = register;
    // }
  }
}
