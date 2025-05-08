// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_flower_request_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFlowerRequestDTO _$AddFlowerRequestDTOFromJson(Map<String, dynamic> json) =>
    AddFlowerRequestDTO(
      name: json['name'] as String,
      homeId: (json['homeId'] as num).toInt(),
      cloudflareImageId: json['cloudflareImageId'] as String?,
      wateringFrequencyDays: (json['wateringFrequencyDays'] as num).toInt(),
    );

Map<String, dynamic> _$AddFlowerRequestDTOToJson(
  AddFlowerRequestDTO instance,
) => <String, dynamic>{
  'name': instance.name,
  'homeId': instance.homeId,
  'cloudflareImageId': instance.cloudflareImageId,
  'wateringFrequencyDays': instance.wateringFrequencyDays,
};
