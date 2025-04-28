import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'models/account.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/register/register_screen.dart';
import 'state/account_provider.dart';
import 'services/auth_service.dart';

class AuthModule {
  static late AuthConfig config;

  static void init(AuthConfig newConfig) {
    config = newConfig;
  }

  static Widget loginScreen() => const LoginScreen();
  static Widget registerScreen() => const RegisterScreen();

  static final accountProvider = accountProviderGlobal;

  static Future<(Account?, String?)> login(
    String email,
    String password,
  ) async {
    return AuthService.login(email, password);
  }

  static Future<(Account?, String?)> register(
    String email,
    String password,
  ) async {
    return AuthService.register(email, password);
  }

  static Future<void> logout(BuildContext context, WidgetRef ref) async {
    await AuthService.logout();
    ref.read(accountProviderGlobal.notifier).clear();

    // Ověření, že prefs jsou vyčištěné, před navigací
    final prefs = await SharedPreferences.getInstance();
    while (prefs.getString('account') != null) {
      await Future.delayed(Duration(milliseconds: 10));
    }

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  static Future<Account?> loginWithToken() {
    return AuthService.loginWithToken();
  }
}
