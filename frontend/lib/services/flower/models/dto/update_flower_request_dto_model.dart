class UpdateFlowerRequestDTO {
  final String? name;
  final DateTime? watter;

  UpdateFlowerRequestDTO({this.name, this.watter});

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (watter != null) 'watter': watter!.toIso8601String(),
  };
}