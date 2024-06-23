import 'package:showcase_app/preferences/user_preferences.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel{

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  Future<void> loadUserData() async {
    _email = await SharedPreferencesHelper.getString('email');
    _name = await SharedPreferencesHelper.getString('username');
    notifyListeners();
  }
}