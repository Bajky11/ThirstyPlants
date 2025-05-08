import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend/screens/_shared_widgets/flower_edit_dialog.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/settings/settings.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    final selectedIndex = useState(0);

    final screens = [HomeScreen(), SettingsScreen()];

    void onItemTapped(int index) {
      print(index);
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
            appBar: AppBar(
              title: Text(""),
              centerTitle: false,
              actionsPadding: EdgeInsets.symmetric(horizontal: 8),
              actions: selectedIndex.value == 0 ? [HomeSelect()] : [],
            ),
            body: SafeArea(child: screens[selectedIndex.value]),
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
              currentIndex: selectedIndex,
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
                showDialog(
                  context: context,
                  builder: (context) => FlowerEditDialog(),
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
