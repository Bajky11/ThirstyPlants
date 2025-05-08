import 'package:json_annotation/json_annotation.dart';

part 'add_home_request_dto_model.g.dart';

@JsonSerializable()
class AddHomeRequestDTO {
  final String name;

  AddHomeRequestDTO({required this.name});

  factory AddHomeRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$AddHomeRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddHomeRequestDTOToJson(this);
}
