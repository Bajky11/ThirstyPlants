import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/services/home/home_query.dart';
import 'package:frontend/services/home/models/dto/add_home_request_dto_model.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddHomeDialog extends HookConsumerWidget {
  const AddHomeDialog({super.key});

  void validateFormAndCreateHome(
    formKey,
    appStateController,
    BuildContext context,
  ) {
    if (!(formKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }

    final data = formKey.currentState!.value;

    addHomeMutation()
        .mutate(AddHomeRequestDTO(name: data["name"]))
        .then((val) {
          appStateController.init();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Home created')));
          Navigator.of(context).pop();
        })
        .onError((error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Error')));
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateController = ref.read(appStateProvider.notifier);
    final formKey = GlobalKey<FormBuilderState>();

    return AlertDialog(
      title: Text("Create new home"),
      content: SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Home name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed:
              () => validateFormAndCreateHome(
                formKey,
                appStateController,
                context,
              ),
          child: Text("Create"),
        ),
      ],
    );
  }
}
