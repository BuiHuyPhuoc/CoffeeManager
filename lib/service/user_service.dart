import 'package:coffee_house/core/constants.dart';
import 'package:coffee_house/models/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<UserAccount?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(CONST_VALUE.PREFERENCES_USERACCOUNT);
    
    if (userString != null) {
      return UserAccount.fromJson(userString);
    }
    return null;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userAccount');
    await prefs.remove('token'); 
    await prefs.remove('isLoggedIn');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}