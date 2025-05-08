import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/modules/auth/auth_module.dart';
import 'package:frontend/modules/auth/functions/functions.dart';
import 'package:frontend/services/home/home_query.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  String? errorMessage;
  bool loading = false;
  bool autoLoginInProgress = false;

  @override
  void initState() {
    super.initState();
    /*
    autoLogin(
      context: context,
      ref: ref,
      setAutoLoginInProgress:
          (value) => setState(() => autoLoginInProgress = value),
    );
    */
  }

  void navigateToRegister() {
    if (context.mounted) {
      Navigator.pushNamed(context, "/register");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (autoLoginInProgress) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              spacing: 24,
              children: [
                // LOGO
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),

                // LOGO
                Text("Login or sign up", style: TextStyle(fontSize: 24)),

                FormBuilderTextField(
                  name: "email",
                  initialValue: "admin",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: FormBuilderValidators.required(),
                ),

                FormBuilderTextField(
                  name: "password",
                  initialValue: "admin",
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Heslo',
                  ),
                  validator: FormBuilderValidators.required(),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed:
                        loading
                            ? null
                            : () async {
                              loading = true;

                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final data = formKey.currentState!.value;

                                final (account, error) = await AuthModule.login(
                                  data['email'],
                                  data['password'],
                                );

                                if (account != null) {
                                  ref
                                      .read(AuthModule.accountProvider.notifier)
                                      .set(account);

                                  ref.invalidate(appStateProvider);
                                  ref.invalidate(homesQueryProvider);

                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/main',
                                    );
                                  }
                                } else {
                                  errorMessage = error;
                                }
                              }

                              loading = false;
                            },
                    child:
                        loading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text("Log in"),
                  ),
                ),

                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      foregroundColor: Colors.blue, // barva textu
                    ),
                    onPressed: navigateToRegister,
                    child: const Text("Continue with Email"),
                  ),
                ),

                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
