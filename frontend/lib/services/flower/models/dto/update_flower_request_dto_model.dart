class UpdateFlowerRequestDTO {
  final String? name;
  final DateTime? watter;
  final int? wateringFrequencyDays;

  UpdateFlowerRequestDTO({this.name, this.watter, this.wateringFrequencyDays});

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (watter != null) 'watter': watter!.toIso8601String(),
    if (wateringFrequencyDays != null)
      "wateringFrequencyDays": wateringFrequencyDays,
  };
}
