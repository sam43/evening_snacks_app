import 'dart:_http';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';

class UserLoginProvider {
  Dio _dio = Dio();

  Future<UserResponse> loginUser(String email, String pass) async {
    try {
      Response response = await _dio.post(
        C.baseURL + C.userLogin,
        data: {"un": email, "up": pass},
        options: Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ),
      );
      print('resp: ${response.data}, params: $email and $pass');
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError('$error');
    }
  }
}
