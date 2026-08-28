# LOCKED IN

A focused, offline-first glow-up companion for training, habits, hydration, streaks, and XP. This repository is the **MINI** version: a coherent, usable core ready to grow into the full LOCKED IN vision.

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

## Flutter project structure

The checked-in project is a Flutter/Dart source tree with its entrypoint at `lib/main.dart` and package manifest at `pubspec.yaml`. The current repository intentionally does **not** check in an `android/` platform wrapper. The APK workflow generates that wrapper on the GitHub runner before building.

```text
lib/
  app.dart, main.dart
  data/                 exercise, habit, and glow-up catalogs
  models/               profile, habit, and workout-log models
  providers/            app state and ChangeNotifier
  services/             shared-preferences repository
  features/             onboarding, dashboard, workout, habits, water, and glow-up UI
  shared/widgets/       shell, progress bar, and section title
web/index.html          lightweight web runner metadata
pubspec.yaml            Flutter package manifest
```

## Run locally

Install Flutter stable, then from the repository root run:

```bash
flutter doctor
flutter pub get
flutter run
```

The Dart source is platform-neutral and uses no platform-specific plugins. For Android development or an APK build, generate the missing Android wrapper once:

```bash
flutter create --platforms=android --project-name locked_in --org com.aryoluke .
flutter pub get
flutter run
```

To build the release APK locally:

```bash
flutter build apk --release
```

The resulting file is:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Android APK delivery through GitHub Actions

Workflow path: [`.github/workflows/build-apk.yml`](.github/workflows/build-apk.yml).

The workflow runs on every branch push, every tag push, and manual dispatch. It:

1. Checks out the repository.
2. Installs the current Flutter **stable** channel on `ubuntu-latest`.
3. Generates `android/` on the runner if it is absent (the repository's current layout needs this step).
4. Runs `flutter pub get`.
5. Runs `flutter build apk --release` from the repository root.
6. Uploads `build/app/outputs/flutter-apk/app-release.apk` as the `locked-in-apk` Actions artifact, retained for 30 days.

### Download an Actions artifact

1. Open the repository's [Actions page](https://github.com/Aryoluke/locked-in/actions).
2. Select **Build Android APK**.
3. Open a completed successful run for the branch or commit you want.
4. On the run summary, under **Artifacts**, select **locked-in-apk** to download the ZIP.
5. Unzip it and install `app-release.apk` on an Android device or emulator.

Artifact links are created per workflow run, so there is no permanent artifact URL until a run has completed. You need repository access to download the artifact.

### Create a tagged release with the APK attached

From a checked-out local clone, after committing the source you want to deliver:

```bash
git checkout main
git pull origin main
git tag v0.1.0
git push origin v0.1.0
```

Replace `v0.1.0` with the release tag you want. The tag push starts the same workflow. When it succeeds, `softprops/action-gh-release` publishes a GitHub Release for that tag, generates release notes, and attaches `app-release.apk` to the release. Download it from the repository's [Releases page](https://github.com/Aryoluke/locked-in/releases). A release is not created for ordinary branch pushes or manual runs.

If you prefer to run it manually, open **Actions → Build Android APK → Run workflow**, choose a branch, and then download the `locked-in-apk` artifact from the completed run. Manual runs do not create a release because they are not tag events.

## Full vision / roadmap

The full product can add adaptive programming, exercise demonstrations, analytics, account sync, reminders, wearable integrations, nutrition, deeper mental-performance protocols, and social accountability. `data/` is the catalog boundary, `AppState` is the persistence boundary, and `features/glow_up/` is the track dashboard stub. Badge data is deliberately a placeholder for a future achievement engine.

This is a starter product, not medical advice. Train responsibly.
