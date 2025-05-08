import 'package:dio/dio.dart';
import 'package:frontend/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<Dio> getDio() async {
  final dio = Dio(
    BaseOptions(baseUrl: getBaseUrl(), contentType: 'application/json'),
  );

  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final jsonString = prefs.getString('account');

        if (jsonString != null) {
          try {
            final token = jsonDecode(jsonString)['token'];
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (_) {}
        }

        handler.next(options);
      },
    ),
  );

  return dio;
}
