import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/screens/camera/camera_screen.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/settings/settings.dart';
import 'package:frontend/services/flower/flower_query.dart';
import 'package:frontend/services/flower/models/dto/add_flower_request_dto_model.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    final selectedIndex = useState(0);

    final screens = [const HomeScreen(), SettingsScreen()];

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return appState.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (error, stack) =>
              Scaffold(body: Center(child: Text('Chyba: $error'))),
      data:
          (state) => Scaffold(
            backgroundColor: const Color(0xFFEEEEEE),
            body: screens[selectedIndex.value],
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: selectedIndex.value,
              onTap: onItemTapped,
            ),
          ),
    );
  }
}

class AppBottomNavigationBar extends HookConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider).asData?.value;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BottomNavigationBar(
              onTap: onTap,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: Color(0xFF445738),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(Icons.local_florist),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(Icons.settings),
                  ),
                  label: '',
                ),
              ],
            ),
            IconButton.filled(
              // TODO: nevím jestli tahle logika se sem uplně hodí.. zvaž to
              onPressed: () async {
                final homeId = appState!.selectedHome!.id;
                final formKey = GlobalKey<FormBuilderState>();

                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('New flower'),
                        // ↙↙ zabalení + pevná max. šířka
                        content: FormBuilder(
                          key: formKey,
                          child: SizedBox(
                            width:
                                300, // nastavte podle vkusu, nebo vynechte pro auto-šířku
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // ← DŮLEŽITÉ
                              children: [
                                FormBuilderTextField(
                                  name: 'name',
                                  decoration: const InputDecoration(
                                    labelText: 'Flower name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.required(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // actions vykreslí tlačítka pod obsahem; samy se přizpůsobí šířce dialogu
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final data = formKey.currentState!.value;

                                await addFlowerMutation(homeId)
                                    .mutate(
                                      AddFlowerRequestDTO(
                                        name: data['name'],
                                        homeId: homeId,
                                      ),
                                    )
                                    .then((val) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Flower created'),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    })
                                    .onError(
                                      (error, stackTrace) => Future(() {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Error'),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      }),
                                    );
                              }
                            },
                            child: const Text('Create'),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.add),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF445738)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(Size(50, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
