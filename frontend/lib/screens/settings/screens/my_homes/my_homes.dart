import 'package:cached_query/cached_query.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/_shared_widgets/add_home_dialog.dart';
import 'package:frontend/screens/settings/screens/my_homes/widgets/home_detail_dialog.dart';
import 'package:frontend/services/home/home_query.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyHomesScreen extends HookConsumerWidget {
  const MyHomesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homesQuery = ref.watch(homesQueryProvider);

    showAddHomeDialog() =>
        showDialog(context: context, builder: (context) => AddHomeDialog());

    return Scaffold(
      appBar: AppBar(title: Text("My homes")),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddHomeDialog,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QueryState<List<Home>>>(
          stream: homesQuery.stream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state == null || state.status == QueryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == QueryStatus.error) {
              return Center(child: Text("Chyba: ${state.error}"));
            }

            final homes = state.data!;

            return ListView.separated(
              itemCount: homes.length,
              itemBuilder: (context, index) {
                return HomeListItem(home: homes[index]);
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        ),
      ),
    );
  }
}

class HomeListItem extends StatelessWidget {
  const HomeListItem({super.key, required this.home});

  final Home home;

  showHomeDetailDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => HomeDetailDialog(home: home),
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(home.name),
      onTap: () => showHomeDetailDialog(context),
      trailing: Icon(Icons.more_vert),
    );
  }
}
