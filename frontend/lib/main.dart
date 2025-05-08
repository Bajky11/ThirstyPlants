import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:frontend/modules/auth/config.dart';
import 'package:frontend/modules/core/theme/app_theme.dart';
import 'package:frontend/screens/app.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/register/register_screen.dart';
import 'package:frontend/screens/settings/screens/my_homes/my_homes.dart';
import 'package:frontend/screens/test/test_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthModule.init(
    AuthConfig(
      baseUrl: getBaseUrl(),
      loginEndpoint: 'auth/login',
      registerEndpoint: 'auth/register',
      tokenLoginEndpoint: "account",
    ),
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        // Main routes
        "/test": (context) => TestScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => App(),
        // Expandable routes
        "/homes": (context) => MyHomesScreen(),
      },
    );
  }
}

String getBaseUrl() {
  bool isProduction = true;

  if (isProduction) {
    String prodUrl = 'https://api.bajerlukas.cz/thirstyPlants/api/';
    print("RUNNING ON PRODUCTION ON ${prodUrl}");
    return prodUrl;
  }

  if (Platform.isAndroid) {
    String androidDevUrl = "http://192.168.0.106:8080/thirstyPlants/api/";
    print("RUNNING ON ANDROID USING ${androidDevUrl} IN LOCAL NETWORK");
    return androidDevUrl;
  } else {
    String pcDevUrl = "http://localhost:8080/thirstyPlants/api/";
    print("RUNNING ON PC USING ${pcDevUrl} IN PC NETWORK");
    return pcDevUrl;
  }
}
