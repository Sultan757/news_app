import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:showcase_app/app/app.locator.dart';
import 'package:showcase_app/models/response/update_profile.dart';
import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:showcase_app/services/local/navigation_services.dart';
import 'package:showcase_app/services/remote/api_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel{

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  String? _existingImage;
  String? get existingImage => _existingImage;
  ApiService apiService = locator<ApiService>();

  Future<void> loadUserData() async {
    _email = await SharedPreferencesHelper.getString('email');
    _name = await SharedPreferencesHelper.getString('username');
    _existingImage = await SharedPreferencesHelper.getString('profile');

    notifyListeners();
  }
  final ImagePicker _picker = ImagePicker();
  File? image;
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
      updateProfile();

    }
  }


  Future<UpdateProfileResponse> updateProfile()async{
   await SharedPreferencesHelper.removeKey('profile');
    final response = await apiService.updateProfileImage(image!);

    if(response.status == 200){
      if(response.data?.profilePicture?[0].url != null){
        SharedPreferencesHelper.saveString("profile", response.data!.profilePicture![0].url!);

      }
      _existingImage = response.data?.profilePicture?[0].url;
      NavService.showSnackBar("Congrats", "${response.message}", const Duration(seconds: 1));
    }
    return response;
  }
}