// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_detail_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDetailResponseDto _$HomeDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) => HomeDetailResponseDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  owner: Account.fromJson(json['owner'] as Map<String, dynamic>),
  accounts:
      (json['accounts'] as List<dynamic>)
          .map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$HomeDetailResponseDtoToJson(
  HomeDetailResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'owner': instance.owner,
  'accounts': instance.accounts,
};
