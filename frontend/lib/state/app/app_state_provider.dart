import 'package:frontend/modules/core/dio/dio_client.dart';
import 'package:frontend/services/home/home_service.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:frontend/state/app/app_state_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  @override
  Future<AppStateData> build() async {
    ref.keepAlive();

    final homes = await HomeService(dio).fetchHomes();

    return AppStateData(selectedHome: homes.isNotEmpty ? homes.first : null);
  }

  void setHome(Home home) {
    state = AsyncData(state.value!.copyWith(selectedHome: home));
  }

  void reset() {
    state = AsyncData(state.value!.copyWith(selectedHome: null));
  }
}
