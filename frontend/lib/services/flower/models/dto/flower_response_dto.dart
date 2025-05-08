import 'package:json_annotation/json_annotation.dart';

part 'flower_response_dto.g.dart';

@JsonSerializable()
class FlowerResponseDTO {
  final int id;
  @JsonKey(defaultValue: null)
  final String? cloudflareImageId;
  final String name;
  final bool needWatter;
  final int daysUntilNextWatering;
  final int wateringFrequencyDays;

  FlowerResponseDTO({
    required this.id,
    required this.cloudflareImageId,
    required this.name,
    required this.needWatter,
    required this.daysUntilNextWatering,
    required this.wateringFrequencyDays
  });

  factory FlowerResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$FlowerResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FlowerResponseDTOToJson(this);
}
