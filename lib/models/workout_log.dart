class WorkoutLog {
  const WorkoutLog({required this.date, required this.exercise, required this.sets, required this.reps, required this.weightKg});

  final DateTime date;
  final String exercise;
  final int sets;
  final int reps;
  final double weightKg;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'exercise': exercise,
        'sets': sets,
        'reps': reps,
        'weightKg': weightKg,
      };

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
        date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
        exercise: json['exercise'] as String? ?? 'Workout',
        sets: (json['sets'] as num?)?.toInt() ?? 1,
        reps: (json['reps'] as num?)?.toInt() ?? 1,
        weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0,
      );
}
