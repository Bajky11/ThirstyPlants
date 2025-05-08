import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/services/home/home_query.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:frontend/services/home/models/dto/home_detail_response_dto.dart';
import 'package:frontend/services/home/models/dto/share_home_request_dto.dart';
import 'package:frontend/services/home/models/dto/unshare_home_request_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeDetailDialog extends HookConsumerWidget {
  const HomeDetailDialog({super.key, required this.home});

  final Home home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return StreamBuilder<QueryState<HomeDetailResponseDto>>(
      stream: homeDetailQuery(ref, home.id).stream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state == null || state.status == QueryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == QueryStatus.error) {
          return Center(child: Text("Chyba: ${state.error}"));
        }

        final homeDetail = state.data!;

        deleteHome() {
          deleteHomeMutation()
              .mutate(home.id)
              .then((val) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Home deleted')));
                Navigator.of(context).pop();
              })
              .onError((error, stackTrace) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error')));
                return Future.error(error ?? 'Neznámá chyba');
              });
        }

        removeSharingHome(accountId) {
          removeSharingHomeMutation(home.id)
              .mutate(UnshareHomeRequestDTO(accountId: accountId))
              .onError((error, stackTrace) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Error')));
                return Future.error(error ?? 'Neznámá chyba');
              });
        }

        validateFormAndShareHome() {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            final data = formKey.currentState!.value;
            shareHomeMutation(home.id)
                .mutate(ShareHomeRequestDTO(email: data["email"]))
                .onError((error, stackTrace) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Error')));
                  return Future.error(error ?? 'Neznámá chyba');
                });
          }
        }

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(homeDetail.name),
              IconButton(
                onPressed: () => deleteHome(),
                icon: Icon(Icons.delete_forever, color: Colors.red),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                FormBuilder(
                  key: formKey,
                  child: Column(
                    spacing: 24,
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'email',
                          border: OutlineInputBorder(),
                          helper: Text(
                            "Invite someone to your home so you can take care of your plants together!",
                          ),
                        ),
                        validator: FormBuilderValidators.required(),
                      ),

                      ElevatedButton(
                        onPressed: () => validateFormAndShareHome(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text("Invite", textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sharing with",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Divider(),
                  ],
                ),

                homeDetail.accounts.isEmpty
                    ? Text("Home is not shared.")
                    : SingleChildScrollView(
                      child: Column(
                        children:
                            homeDetail.accounts.map((account) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(account.email),
                                  IconButton(
                                    onPressed:
                                        () => removeSharingHome(account.id),
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
