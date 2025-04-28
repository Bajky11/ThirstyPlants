// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowerResponseDTO _$FlowerResponseDTOFromJson(Map<String, dynamic> json) =>
    FlowerResponseDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      needWatter: json['needWatter'] as bool,
    );

Map<String, dynamic> _$FlowerResponseDTOToJson(FlowerResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'needWatter': instance.needWatter,
    };
