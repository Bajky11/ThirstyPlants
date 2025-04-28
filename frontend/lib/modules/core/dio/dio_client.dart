import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:8080/flowercare/api/',
  contentType: 'application/json',
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('account');

      if (jsonString != null) {
        try {
          final token = jsonDecode(jsonString)['token'];
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (_) {
          // JSON parsing chyba – smaž account
          prefs.remove('account');
        }
      }

      handler.next(options);
    },

    onError: (DioException e, handler) async {
      // Pokud je odpověď 401 – token je neplatný nebo expiroval
      if (e.response?.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('account');

        // Pokud máš BuildContext globálně, můžeš redirectovat rovnou
        // nebo emitnout event do Riverpodu nebo jiného stavu

        // Příklad fallbacku:
        // showLoginScreen(); nebo restart aplikace
      }

      handler.next(e); // propaguj chybu dál
    },
  ));