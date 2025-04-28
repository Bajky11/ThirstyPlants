import 'package:flutter/material.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend/services/flower/flower_query.dart';
import 'package:frontend/services/flower/models/data/flower_model.dart';
import 'package:frontend/services/flower/models/dto/flower_response_dto.dart';
import 'package:frontend/services/flower/models/dto/update_flower_request_dto_model.dart';
import 'package:frontend/services/home/home_query.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider).asData?.value;

    return Column(
      spacing: 32,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Row(children: [HomeSelect()]),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QueryState<List<FlowerResponseDTO>>>(
              stream: flowersQuery(appState!.selectedHome!.id).stream,
              builder: (context, snapshot) {
                final state = snapshot.data;

                if (state == null || state.status == QueryStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == QueryStatus.error) {
                  return Center(child: Text("Chyba: ${state.error}"));
                }

                final flowers = state.data!;

                if (flowers.isEmpty) {
                  return Text("There are no flowers yet.");
                }

                final sortedFlowers =
                    flowers.toList()..sort(
                      (a, b) => b.needWatter.toString().compareTo(
                        a.needWatter.toString(),
                      ),
                    );

                int numOfFlowersThatNeedWater =
                    flowers.where((e) => e.needWatter).length;

                return Column(
                  spacing: 48,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlowersStatusText(numOfFlowersThatNeedWater),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          spacing: 8,
                          children:
                              sortedFlowers
                                  .map((f) => FlowerCard(flower: f))
                                  .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            /*
            // TEST
            ElevatedButton(
              onPressed: () async {
                /* await notifier.updateFlower(
              1,
              name: 'slunecnice (Upraveno)',
              watter: DateTime.now(),
            );
            */
              },
              child: const Text("Upravit květinu"),
            ),
            */
          ],
        ),
      ],
    );
  }
}

class FlowersStatusText extends HookConsumerWidget {
  final int numOfFlowersThatNeedWater;

  const FlowersStatusText(this.numOfFlowersThatNeedWater, {super.key});

  List<TextSpan> get flowersNeedAttention => [
    const TextSpan(text: "1 "),
    const TextSpan(text: "plant "),
    const TextSpan(
      text: "needs",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const TextSpan(text: " your attention  "),
  ];

  List<TextSpan> get flowersOk => [
    const TextSpan(text: "Your plants are "),
    const TextSpan(
      text: "chilling",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20 + 4),

      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge!,
          children:
              numOfFlowersThatNeedWater != 0 ? flowersNeedAttention : flowersOk,
        ),
      ),
    );
  }
}

class HomeSelect extends HookConsumerWidget {
  const HomeSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider).asData?.value;
    final appStateController = ref.read(appStateProvider.notifier);
    final home = ref.watch(homesQueryProvider);

    useEffect(() {
      home.refetch();
      return null;
    }, const []);

    return StreamBuilder<QueryState<List<Home>>>(
      stream: home.stream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state == null || state.status == QueryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == QueryStatus.error) {
          return Center(child: Text("Chyba: ${state.error}"));
        }

        final homes = state.data!;

        return PopupMenuButton<Home>(
          initialValue: home.state.data?.first,
          onSelected: (val) {
            //setSelectedHome.state = val;
            appStateController.setHome(val);
          },
          itemBuilder:
              (context) =>
                  homes.map((home) {
                    return PopupMenuItem<Home>(
                      value: home,
                      child: Text(
                        home.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          elevation: 8,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 12,
              children: [
                Icon(Icons.home_rounded, size: 20),
                Row(
                  children: [
                    Text(
                      appState!.selectedHome?.name ?? "not selected",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FlowerCard extends HookConsumerWidget {
  final FlowerResponseDTO flower;
  const FlowerCard({super.key, required this.flower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider).asData?.value;

    return Card(
      color: Color(0xFF445738),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                'https://myuncommonsliceofsuburbia.com/wp-content/uploads/2023/07/snake-plant-4985304_1280-682x1024.jpg',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    flower.name,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          flower.needWatter
                              ? () async {
                                await updateFlowerMutation(
                                      flower.id,
                                      appState!.selectedHome!.id,
                                    )
                                    .mutate(
                                      UpdateFlowerRequestDTO(
                                        watter:  DateTime.now().toUtc(),
                                      ),
                                    )
                                    .then((val) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Flower wattered'),
                                        ),
                                      );
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
                                      }),
                                    );
                              }
                              : null,
                      child: Text("watter"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
