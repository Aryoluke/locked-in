class UserProfile {
  const UserProfile({required this.name, required this.age, required this.heightCm, required this.weightKg, required this.bodyType, required this.goals, required this.equipment});

  final String name;
  final int age;
  final double heightCm;
  final double weightKg;
  final String bodyType;
  final String goals;
  final String equipment;

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'bodyType': bodyType,
        'goals': goals,
        'equipment': equipment,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] as String? ?? '',
        age: (json['age'] as num?)?.toInt() ?? 18,
        heightCm: (json['heightCm'] as num?)?.toDouble() ?? 0,
        weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0,
        bodyType: json['bodyType'] as String? ?? 'Hybrid',
        goals: json['goals'] as String? ?? '',
        equipment: json['equipment'] as String? ?? '',
      );
}
