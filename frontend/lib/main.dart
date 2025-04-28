import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:frontend/modules/auth/config.dart';
import 'package:frontend/modules/core/theme/app_theme.dart';
import 'package:frontend/screens/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthModule.init(
     AuthConfig(
      baseUrl: 'http://localhost:8080/flowercare/api/',
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
        '/login': (context) => AuthModule.loginScreen(),
        '/register': (context) => AuthModule.registerScreen(),
        '/main': (context) => App(),
      },
    );
  }
}

String getBaseUrl() {
  if (Platform.isAndroid) {
    print("anroid");
    return 'http://10.0.2.2:3000';
  } else {
    print("localhost");
    return 'http://localhost:3000';
  }
}
