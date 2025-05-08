import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestScreen extends HookConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Text("TEST"),
          ElevatedButton(
            onPressed: () {
              AuthModule.logout(context, ref);
            },
            child: Text("logout"),
          ),
        ],
      ),
    );
  }
}
