import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/modules/auth/functions/functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../modules/auth/auth_module.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  String? errorMessage;
  bool loading = false;

  void navigateToLogin() {
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
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
              Text("Register", style: TextStyle(fontSize: 24)),

              FormBuilderTextField(
                name: "email",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),

              FormBuilderTextField(
                name: "password",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: FormBuilderValidators.required(),
              ),

              FormBuilderTextField(
                name: "repeatPassword",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repeat password',
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
                          : () {
                            register(
                              context: context,
                              ref: ref,
                              formKey: _formKey,
                              setLoading: (v) => setState(() => loading = v),
                              setError:
                                  (err) => setState(() => errorMessage = err),
                            );
                          },
                  child:
                      loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Register"),
                ),
              ),

              if (errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
