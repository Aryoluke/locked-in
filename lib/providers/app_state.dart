import 'package:flutter/foundation.dart';

import '../data/habits.dart';
import '../models/user_profile.dart';
import '../models/workout_log.dart';
import '../services/local_storage_service.dart';

class AppState extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final List<WorkoutLog> workoutLogs = [];
  final Map<String, bool> completedHabits = {for (final habit in starterHabits) habit.id: false};
  UserProfile? profile;
  int waterMl = 0;
  int xp = 0;
  bool isReady = false;

  Future<void> load() async {
    await _storage.init();
    profile = _storage.readProfile();
    workoutLogs.addAll(_storage.readLogs());
    completedHabits.addAll(_storage.readHabits());
    waterMl = _storage.readInt('water_ml');
    xp = _storage.readInt('xp');
    isReady = true;
    notifyListeners();
  }

  int get level => 1 + xp ~/ 250;
  int get levelXp => xp % 250;
  double get levelProgress => levelXp / 250;
  int get streak {
    final days = workoutLogs.map((log) => _dateKey(log.date)).toSet();
    var count = 0;
    var day = DateTime.now();
    while (days.contains(_dateKey(day))) {
      count++;
      day = day.subtract(const Duration(days: 1));
    }
    return count;
  }

  static String _dateKey(DateTime date) => date.toIso8601String().substring(0, 10);

  Future<void> saveProfile(UserProfile value) async {
    profile = value;
    await _storage.saveProfile(value);
    notifyListeners();
  }

  void toggleHabit(String id, int reward) {
    final next = !(completedHabits[id] ?? false);
    completedHabits[id] = next;
    if (next) xp += reward;
    _storage.saveHabits(completedHabits);
    _storage.saveInt('xp', xp);
    notifyListeners();
  }

  void addWater(int amount) {
    waterMl += amount;
    if (waterMl >= 2000 && waterMl - amount < 2000) xp += 25;
    _storage.saveInt('water_ml', waterMl);
    _storage.saveInt('xp', xp);
    notifyListeners();
  }

  void resetWater() {
    waterMl = 0;
    _storage.saveInt('water_ml', waterMl);
    notifyListeners();
  }

  void logWorkout(WorkoutLog log) {
    workoutLogs.insert(0, log);
    xp += 35;
    _storage.saveLogs(workoutLogs);
    _storage.saveInt('xp', xp);
    notifyListeners();
  }
}
