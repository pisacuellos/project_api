class Character {
  final String id;
  final String name;
  final String avatar;
  final int birthDate;
  final String order;
  double note;

  Character({
    required this.id,
    required this.name,
    required this.avatar,
    required this.birthDate,
    required this.order,
    required this.note,
  });

  // Método para convertir un JSON en una instancia de Character
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      birthDate: json['birth_date'],
      order: json['order'],
      note: double.tryParse(json['note'].toString()) ?? 0.0,
    );
  }

  // Método para convertir una instancia de Character a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'birth_date': birthDate,
      'order': order,
      'note': note,
    };
  }
}
