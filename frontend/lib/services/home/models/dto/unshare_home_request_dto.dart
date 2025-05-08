import 'package:json_annotation/json_annotation.dart';

part 'unshare_home_request_dto.g.dart';

@JsonSerializable()
class UnshareHomeRequestDTO {
  final int accountId;

  UnshareHomeRequestDTO({required this.accountId});

  factory UnshareHomeRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$UnshareHomeRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UnshareHomeRequestDTOToJson(this);
}
