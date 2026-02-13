import 'package:get_storage/get_storage.dart';

class StorageServices {
  static String accessTokenKey = 'accessToken';

  static bool isLoggedIn()  {
    final box = GetStorage();
    String token = box.read(accessTokenKey) ?? '';

    if(token != '' || token.isNotEmpty){
      return true;
    }
    return false;
  }

  static Future<void> setToken(String token) async {
    final box = GetStorage();

    await box.write(accessTokenKey, token);
  }
}
