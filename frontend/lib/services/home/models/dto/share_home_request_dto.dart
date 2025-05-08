import 'package:json_annotation/json_annotation.dart';

part 'share_home_request_dto.g.dart';

@JsonSerializable()
class ShareHomeRequestDTO {
  final String email;

  ShareHomeRequestDTO({required this.email});

  factory ShareHomeRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ShareHomeRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ShareHomeRequestDTOToJson(this);
}
