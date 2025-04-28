import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../auth_module.dart';

Future<void> loginWithForm({
  required BuildContext context,
  required WidgetRef ref,
  required GlobalKey<FormBuilderState> formKey,
  required void Function(bool) setLoading,
  required void Function(String?) setError,
}) async {
  setLoading(true);
  setError(null);

  final isValid = formKey.currentState?.saveAndValidate() ?? false;
  if (!isValid) {
    setLoading(false);
    return;
  }

  final data = formKey.currentState!.value;
  final (account, error) = await AuthModule.login(
    data['email'],
    data['password'],
  );

  if (account != null) {
    ref.read(AuthModule.accountProvider.notifier).set(account);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  } else {
    setError(error);
  }

  setLoading(false);
}

Future<void> autoLogin({
  required BuildContext context,
  required WidgetRef ref,
  required void Function(bool) setAutoLoginInProgress,
}) async {
  final account = await AuthModule.loginWithToken();

  if (!context.mounted) return;

  if (account != null) {
    ref.read(AuthModule.accountProvider.notifier).set(account);
    Navigator.pushReplacementNamed(context, '/main');
  } else {
    setAutoLoginInProgress(false);
  }
}

Future<void> register({
  required BuildContext context,
  required WidgetRef ref,
  required GlobalKey<FormBuilderState> formKey,
  required void Function(bool) setLoading,
  required void Function(String?) setError,
}) async {
  setLoading(true);
  setError(null);

  final isValid = formKey.currentState?.saveAndValidate() ?? false;
  if (!isValid) {
    setLoading(false);
    return;
  }

  final data = formKey.currentState!.value;
  final (account, error) = await AuthModule.register(
    data['email'],
    data['password'],
  );

  if (account != null) {
    ref.read(AuthModule.accountProvider.notifier).set(account);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  } else {
    setError(error);
  }

  setLoading(false);
}
