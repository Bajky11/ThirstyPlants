import 'package:json_annotation/json_annotation.dart';

part 'add_flower_request_dto_model.g.dart';

@JsonSerializable()
class AddFlowerRequestDTO {
  final String name;
  final int homeId;
  final String? cloudflareImageId;
  final int wateringFrequencyDays;

  AddFlowerRequestDTO({
    required this.name,
    required this.homeId,
    required this.cloudflareImageId,
    required this.wateringFrequencyDays
  });

  factory AddFlowerRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$AddFlowerRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddFlowerRequestDTOToJson(this);
}
