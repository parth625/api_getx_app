import 'dart:developer';

import 'package:api_app/models/user.dart';
import 'package:api_app/services/storage_services.dart';
import 'package:dio/dio.dart';

class AuthServices {
  // static final AuthServices _instance = AuthServices._internal();
  //
  // factory AuthServices() {
  //   return _instance;
  // }
  //
  // AuthServices._internal();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      log('${response.statusCode}');

      if (response.statusCode == 200) {
        var data = response.data;

        log('$response');
        User user = User.fromJson(data);

        log('Token: ${user.accessToken}');

        dio.options.headers['Authorization'] = 'Bearer ${user.accessToken}';
        StorageServices.setToken(
          user.accessToken ?? '',
        );

        return true;
      }
    } on DioException catch (e) {
      log('Error: ${e.message}');
    }

    return false;
  }
  
  Future<User?> getCurrentAuthUser() async{
    try{
      final response = await dio.get('/auth/me');

      // log('Current user: ${response.statusCode}');

      if(response.statusCode == 200){
        final data = response.data;

        log('Current user raw data: $data');

        return User.fromJson(data);
      }
    } on DioException catch(e){
      log('Error: ${e.message}');
      return null;
    }
    return null;
  }
}
