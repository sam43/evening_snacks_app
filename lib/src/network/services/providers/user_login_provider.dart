import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evening_snacks_app/src/network/models/models.dart';
import 'package:evening_snacks_app/src/network/models/user_login_response.dart';
import 'package:evening_snacks_app/src/utils/constants.dart';

class ApiProvider {
  Dio _dio = Dio();

  ApiProvider() {
    Options options = Options(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<UserResponse> userLogin(String email, String pass) async {
    try {
      Response response = await _dio.post(
        C.baseURL + C.userLogin,
        data: {"un": email, "up": pass},
        options: Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
          },
        ),
      );
      print('resp: ${response.data}, params: $email and $pass');
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError(_handleError(error));
    }
  }

  Future<MyOrder> checkOrder(String _gid) async {
    try {
      print('userID1: $_gid');
      Response response = await _dio.get(
          C.baseURL + C.orderToday + '?userid=$_gid');
      print('resp: ${response.data}, params: $_gid');
      return MyOrder.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MyOrder.withError(_handleError(error));
    }
  }

  Future<MakeOrder> makeOrder(String userid, String uname, String menu,
      {String corder}) async {
    String _coOrder;
    if (corder == null) {
      _coOrder = '';
    } else
      _coOrder = corder;
    try {
      print('userIDmake: $userid');
      Response response = await _dio.get(
          C.baseURL + C.orderSnacks +
              '?userid=$userid&uname=$uname&menu=$menu&corder=$_coOrder');
      print('resp: ${response.data}, params: $userid');
      return MakeOrder.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MakeOrder.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptor.request.onSend = (Options options) {
      print("--> ${options.method} ${options.path}");
      print("Content type: ${options.contentType}");
      print("<-- END HTTP");
      return options;
    };

    _dio.interceptor.response.onSuccess = (Response response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response
              .request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
        (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    };
  }

}
