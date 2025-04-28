import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/services/home/models/data/home_model.dart';

part 'app_state_data.freezed.dart';

@freezed
class AppStateData with _$AppStateData {
  const factory AppStateData({
    Home? selectedHome,
  }) = _AppStateData;
}