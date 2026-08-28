# LOCKED IN

A focused, offline-first glow-up companion for training, habits, hydration, streaks, and XP. This repository is the **MINI** version: a coherent, usable core that is ready to grow into the full LOCKED IN vision.

## Mini version

- Guided onboarding for name, age, height, weight, body type, goals, and equipment.
- Dashboard with today's plan, streak flame, XP, and lock-in level.
- Workout logging for sets, reps, and weight with a calisthenics + gym exercise library.
- Starter habits: water, creatine, skincare, and study.
- Water tracking with a daily target.
- Local offline persistence with `shared_preferences`.
- Streaks, XP levels, and badge placeholders.
- Four glow-up tracks: Normal, Gym, Mental & Brain, and Physical.
- Dark charcoal / emerald / gold visual system.

## Run it

Install Flutter stable, then:

```bash
flutter doctor
flutter pub get
flutter run -d chrome       # web
flutter run -d windows      # Windows desktop
flutter run                 # Android device or emulator
```

The Dart source is platform-neutral and uses no platform-specific plugins. If a checkout needs generated runners, create the standard Android, Windows, and web wrappers once:

```bash
flutter create --platforms=android,windows,web .
flutter pub get
```

`shared_preferences` uses browser storage on web and the platform local preferences store on Android/Windows.

## Project structure

```text
lib/
  app.dart, main.dart
  data/                 exercise, habit, and glow-up catalogs
  models/               profile, habit, workout log
  providers/            AppState ChangeNotifier
  services/             SharedPreferences repository
  features/
    onboarding/         profile setup
    dashboard/          today's plan and metrics
    workout/            exercise logging
    habits/             starter habit checklist
    water/              hydration tracker
    glow_up/            four-track progress stubs
  shared/widgets/       shell, progress bar, section title
web/                    lightweight web runner metadata
```

## Full vision / roadmap

The full product can add adaptive programming, exercise demonstrations, analytics, account sync, reminders, wearable integrations, nutrition, deeper mental performance protocols, and social accountability. `data/` is the catalog boundary, `AppState` is the persistence boundary, and `features/glow_up/` is the track dashboard stub. Badge data is deliberately a placeholder for a future achievement engine.

This is a starter product, not medical advice. Train responsibly.
