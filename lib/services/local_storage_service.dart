import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';
import '../models/workout_log.dart';

class LocalStorageService {
  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  UserProfile? readProfile() {
    final raw = _prefs.getString('profile');
    return raw == null ? null : UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveProfile(UserProfile profile) => _prefs.setString('profile', jsonEncode(profile.toJson()));

  List<WorkoutLog> readLogs() {
    final raw = _prefs.getString('workout_logs');
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>)
        .map((item) => WorkoutLog.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveLogs(List<WorkoutLog> logs) => _prefs.setString('workout_logs', jsonEncode(logs.map((log) => log.toJson()).toList()));
  Map<String, bool> readHabits() {
    final raw = _prefs.getString('habits');
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map((key, value) => MapEntry(key, value == true));
  }
  Future<void> saveHabits(Map<String, bool> habits) => _prefs.setString('habits', jsonEncode(habits));
  int readInt(String key) => _prefs.getInt(key) ?? 0;
  Future<void> saveInt(String key, int value) => _prefs.setInt(key, value);
}
