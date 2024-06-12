import 'package:showcase_app/models/response/login_response.dart';
import 'package:showcase_app/models/response/register_response.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:stacked/stacked.dart';

class NewsDetailsViewModel extends BaseViewModel{
  FinalUser? retrieveUserDetails;
  LoginData? retrieveLoginUserDetails;
  onInit() async{

    // register object retrieve
    final LoginData? consumerPayload =
    await SharedPreferencesHelper.getObject<LoginData>(
      'userPayload',
          (data) => LoginData.fromJson(data),
    );

    retrieveLoginUserDetails = consumerPayload;

    final FinalUser? registerPayload =
    await SharedPreferencesHelper.getObject<FinalUser>(
      'registerPayload',
          (data) => FinalUser.fromJson(data),
    );
    retrieveUserDetails = registerPayload;
  }


}