// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowerResponseDTO _$FlowerResponseDTOFromJson(Map<String, dynamic> json) =>
    FlowerResponseDTO(
      id: (json['id'] as num).toInt(),
      cloudflareImageId: json['cloudflareImageId'] as String?,
      name: json['name'] as String,
      needWatter: json['needWatter'] as bool,
      daysUntilNextWatering: (json['daysUntilNextWatering'] as num).toInt(),
      wateringFrequencyDays: (json['wateringFrequencyDays'] as num).toInt(),
    );

Map<String, dynamic> _$FlowerResponseDTOToJson(FlowerResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cloudflareImageId': instance.cloudflareImageId,
      'name': instance.name,
      'needWatter': instance.needWatter,
      'daysUntilNextWatering': instance.daysUntilNextWatering,
      'wateringFrequencyDays': instance.wateringFrequencyDays,
    };
