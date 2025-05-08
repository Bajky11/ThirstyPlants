import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'models/account.dart';
import 'state/account_provider.dart';
import 'services/auth_service.dart';

class AuthModule {
  static late AuthConfig config;

  static void init(AuthConfig newConfig) {
    config = newConfig;
  }

  static final accountProvider = accountProviderGlobal;

  static Future<(Account?, String?)> login(
    String email,
    String password,
  ) {
    return const AuthService().login(email, password);
  }

  static Future<(Account?, String?)> register(
    String email,
    String password,
  ) {
    return const AuthService().register(email, password);
  }

  static Future<Account?> loginWithToken() {
    return const AuthService().loginWithToken();
  }

  static Future<void> logout(BuildContext context, WidgetRef ref) async {
    await const AuthService().logout();
    ref.read(accountProviderGlobal.notifier).clear();

    final prefs = await SharedPreferences.getInstance();
    while (prefs.getString('account') != null) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }
}