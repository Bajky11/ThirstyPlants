class AddFlowerRequestDTO {
  final String name;
  final int homeId;

  AddFlowerRequestDTO({required this.name, required this.homeId});

  Map<String, dynamic> toJson() => {
    'name': name,
    'homeId': homeId,
  };
}