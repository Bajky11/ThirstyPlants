import 'package:flutter/material.dart';
import 'package:cached_query/cached_query.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/screens/_shared_widgets/add_home_dialog.dart';
import 'package:frontend/screens/_shared_widgets/flower_edit_dialog.dart';
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

    showAddHomeDialog() =>
        showDialog(context: context, builder: (context) => AddHomeDialog());

    if (appState!.selectedHome == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Text(
                "Start by creating yout first home",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),

              SvgPicture.asset(
                'lib/resources/images/undraw_back-home.svg',
                height: 300,
                fit: BoxFit.contain,
              ),

              ElevatedButton(
                onPressed: () => showAddHomeDialog(),
                child: Text("Create home"),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
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
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No plants here.",
                            style: TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Use the plus button below to add your first plant.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SvgPicture.asset(
                            'lib/resources/images/undraw_outdoors.svg',
                            fit: BoxFit.contain,
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  );
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
                  spacing: 40,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlowersStatusText(numOfFlowersThatNeedWater),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          bottom: 80,
                        ),
                        child: Row(
                          spacing: 12,
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
    TextSpan(text: numOfFlowersThatNeedWater.toString()),
    const TextSpan(text: " plants "),
    const TextSpan(
      text: "needs",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const TextSpan(text: " you!"),
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
      padding: const EdgeInsets.symmetric(horizontal: 16 + 4),

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

    if (appState?.selectedHome == null) {
      return SizedBox();
    }

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

        // TODO tady když to vymažu nastane chyba... občas.
        if (homes.isEmpty) {
          return SizedBox();
        }

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
              spacing: 8,
              children: [
                Text(
                  appState!.selectedHome?.name ?? "not selected",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.arrow_drop_down, size: 16),
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

    showFlowerEditDialog(FlowerResponseDTO flower) => showDialog(
      context: context,
      builder: (context) => FlowerEditDialog(flower: flower),
    );

    return GestureDetector(
      onLongPress: () => showFlowerEditDialog(flower),
      child: Card(
        color: Color(0xFF445738),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 280,
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
                  flower.cloudflareImageId != null
                      ? "https://imagedelivery.net/UBZWeFQQoLk6g5JDQWgvdQ/${flower.cloudflareImageId}/public"
                      : 'https://myuncommonsliceofsuburbia.com/wp-content/uploads/2023/07/snake-plant-4985304_1280-682x1024.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Pokud je v db ID obrazku co už v cloudflare není, spadne to sem..
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://myuncommonsliceofsuburbia.com/wp-content/uploads/2023/07/snake-plant-4985304_1280-682x1024.jpg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    //Scrolovatelný text
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        flower.name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
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
                                          watter: DateTime.now().toUtc(),
                                        ),
                                      )
                                      .then((val) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Plant wattered'),
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
                        child: Text(
                          flower.needWatter
                              ? "watter"
                              : "In ${flower.daysUntilNextWatering} days",
                          style: TextStyle(
                            color: flower.needWatter ? null : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
