import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:frontend/modules/auth/utils/http_errors.dart';
import 'package:frontend/modules/core/dio/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_module.dart';
import '../models/account.dart';

class AuthService {
  const AuthService();

  Future<(Account?, String?)> login(String email, String password) async {
    try {
      final dio = await getDio();

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

  Future<(Account?, String?)> register(String email, String password) async {
    try {
      final dio = await getDio();

      final response = await dio.post(
        AuthModule.config.registerEndpoint,
        data: {'email': email, 'password': password},
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

  Future<Account?> loginWithToken() async {
    try {
      final dio = await getDio();

      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString('account');

      if (json != null) {
        final token = jsonDecode(json)['token'];
        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await dio.get(AuthModule.config.tokenLoginEndpoint);
      return Account.fromJson(response.data);
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('account');
  }
}