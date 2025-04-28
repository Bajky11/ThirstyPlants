import 'package:json_annotation/json_annotation.dart';

part 'flower_model.g.dart';

@JsonSerializable()
class Flower {
  final int id;
  final String name;
  final DateTime watter;
  final bool needWatter;

  Flower({
    required this.id,
    required this.name,
    required this.watter,
    required this.needWatter,
  });

  factory Flower.fromJson(Map<String, dynamic> json) => _$FlowerFromJson(json);

  Map<String, dynamic> toJson() => _$FlowerToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flower && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Flower(id: $id, name: $name)';
}
