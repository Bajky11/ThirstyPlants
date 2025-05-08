import 'package:frontend/services/account/models/data/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_detail_response_dto.g.dart';

@JsonSerializable()
class HomeDetailResponseDto {
  final int id;
  final String name;
  final Account owner;
  final List<Account> accounts;

  HomeDetailResponseDto({
    required this.id,
    required this.name,
    required this.owner,
    required this.accounts,
  });

  factory HomeDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDetailResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDetailResponseDtoToJson(this);
}
