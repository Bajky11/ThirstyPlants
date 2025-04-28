import 'package:json_annotation/json_annotation.dart';

part 'flower_response_dto.g.dart';

@JsonSerializable()
class FlowerResponseDTO {
  final int id;
  final String name;
  final bool needWatter;

  FlowerResponseDTO({
    required this.id,
    required this.name,
    required this.needWatter,
  });

  factory FlowerResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$FlowerResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FlowerResponseDTOToJson(this);
}
