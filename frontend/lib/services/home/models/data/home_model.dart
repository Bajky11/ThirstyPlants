import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class Home {
  final int id;
  final String name;

  Home({required this.id, required this.name});

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Home && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Home(id: $id, name: $name)';
}
