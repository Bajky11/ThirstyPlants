import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("My homes"),
            onTap: () {
              Navigator.pushNamed(context, "/homes");
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout_outlined, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              AuthModule.logout(context, ref);
            },
          ),
        ],
      ),
    );
  }
}
