// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flower _$FlowerFromJson(Map<String, dynamic> json) => Flower(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  watter: DateTime.parse(json['watter'] as String),
  needWatter: json['needWatter'] as bool,
);

Map<String, dynamic> _$FlowerToJson(Flower instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'watter': instance.watter.toIso8601String(),
  'needWatter': instance.needWatter,
};
