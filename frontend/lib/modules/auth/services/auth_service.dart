import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:frontend/modules/auth/utils/http_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_module.dart';
import '../models/account.dart';

class AuthService {
  static final Dio dio = Dio(
      BaseOptions(
        baseUrl: AuthModule.config.baseUrl,
        contentType: 'application/json',
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final ignoredPaths = [
            AuthModule.config.loginEndpoint,
            AuthModule.config.registerEndpoint,
          ];

          if (!ignoredPaths.any((path) => options.path.endsWith(path))) {
            final prefs = await SharedPreferences.getInstance();
            final jsonString = prefs.getString('account');
            if (jsonString != null) {
              try {
                final token = jsonDecode(jsonString)['token'];
                if (token != null) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
              } catch (_) {}
            }
          }

          handler.next(options);
        },
      ),
    );

  static Future<(Account?, String?)> login(
    String email,
    String password,
  ) async {
    try {
      final prefss = await SharedPreferences.getInstance();
      print(prefss.get("account"));

      final response = await dio.post(
        AuthModule.config.loginEndpoint,
        data: {'email': email, 'password': password},
      );

      final account = Account.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('account', jsonEncode(account.toJson()));

      return (account, null);
    } on DioException catch (e) {
      final message = parseDioError(e, fallback: 'Chyba při přihlašování');

      return (null, message);
    } catch (_) {
      return (null, 'Neznámá chyba při přihlášení');
    }
  }

  static Future<(Account?, String?)> register(
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post(
        AuthModule.config.registerEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      final account = Account.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('account', jsonEncode(account.toJson()));

      return (account, null);
    } on DioException catch (e) {
      final message = parseDioError(e, fallback: 'Chyba při registraci');
      return (null, message);
    } catch (_) {
      return (null, 'Neznámá chyba při registraci');
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('account');
  }

  static Future<Account?> loginWithToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString('account');

      if (json != null) {
        final token = jsonDecode(json)['token'];
        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer $token';
        }
      }
      final response = await dio.get(AuthModule.config.tokenLoginEndpoint);
      final account = Account.fromJson(response.data);
      return account;
    } on DioException catch (e) {
      parseDioError(e, fallback: 'Chyba při auto přihlášení');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("account");
      return null;
    } catch (e) {
      print("Fatální chyba při auto přihlášení");
      return null;
    }
  }
}
