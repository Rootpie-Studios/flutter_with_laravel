import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_with_laravel/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class ApiProvider {
  late Dio _dio;

  final BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: CONNECTION_TIMEOUT,
    receiveTimeout: RECIEVE_TIMEOUT,
    contentType: ContentType.json.toString(),
  );

  ApiProvider() {
    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['Authorization'] = 'Bearer ' + await _getToken();
      return handler.next(options);
    }, onResponse:
        (Response<dynamic> response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      return handler.next(e);
    }
    ));
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasToken = prefs.containsKey('token');
    if (hasToken) {
      return prefs.getString('token')!;
    }
    else {
      return "";
    }
  }

  postData(apiUrl, data) async {
    try {
      final Response response = await _dio.post(apiUrl, data: data);
      Map<String, dynamic> res = {
        'data': response.data,
        'status_code': response.statusCode,
      };
      return res;
    } catch (err) {
      print(err);
      return {'status_code' : 500};
    }
  }

  getData(apiUrl) async {
    try {
      final Response response = await _dio.get(apiUrl);
      Map<String, dynamic> res = {
        'data': response.data,
        'status_code': response.statusCode,
      };
      return res;
    } catch (err) {
      print(err);
      return {'status_code' : 500};
    }
  }

  Future<bool> login(Map<String, dynamic> credentials) async {
    final prefs = await SharedPreferences.getInstance();
    var response = await postData('login', credentials);

    if (response['status_code'] == 200) {
      await prefs.setString('token', response['data']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic response = await getData('logout');

    if (response['status_code'] == 200) {
      await prefs.setString('token', '');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> user_data) async {
    final prefs = await SharedPreferences.getInstance();
    var response = await postData('register', user_data);

    if (response['status_code'] == 200) {
      await prefs.setString('token', response['data']);
      return true;
    } else {
      return false;
    }
  }

  Future<User?> fetchUser() async {
    var response = await getData('user');

    if (response['status_code'] == 200) {
      User user = User.fromJson(
        response['data']['user'],
      );
      return user;
    } else {
      return null;
    }
  }

  Future<bool> checkAuth() async {
    dynamic response = await getData('check');
    if (response['status_code'] == 200 && response['data'] == 'OK') {
      return true;
    }
    else {
      return false;
    }
  }
}