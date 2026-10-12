# Plat it — Phase 0 Starter Package

This package contains everything needed to produce the first real binaries of
Plat it – Social Music (c) Baraily Innovation:

| Deliverable | How you get it |
|---|---|
| Android `.apk` | GitHub Actions job `apk` (or `flutter build apk` locally) |
| Windows `.exe` NSIS installer | GitHub Actions job `windows` (or local build below) |

## Option A — GitHub Actions (recommended, no local setup)

1. Create a new GitHub repository and push these files to the `main` branch.
2. Open **Actions** → run **Build Plat it**. Wait ~10 minutes.
3. Download artifacts:
   - `platit-android-debug-apk` → install `app-debug.apk` on any Android phone.
   - `platit-windows-installer` → `platit-0.1.0-setup.exe`, a real NSIS installer
     with shortcuts, Start Menu entry, and uninstaller.

## Option B — Local build

Prerequisites: [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable),
Android Studio (for the Android SDK), and [NSIS](https://nsis.sourceforge.io).

```bash
flutter create --org ai.baraily --platforms=android,ios,windows .
flutter pub get
cp /path/to/your/logo.png assets/logo.png   # brand asset (blue circle, black play symbol)

# Android APK
flutter build apk --release      # build\app\outputs\flutter-apk\app-release.apk

# Windows + NSIS installer
flutter build windows --release
makensis installer/platit_installer.nsi    # outputs platit-0.1.0-setup.exe
```

## What this build is — and is not

This is the **Phase 0 foundation** from the architecture roadmap: the real,
runnable app shell with branded theming, light/dark mode, platform-adaptive
navigation (bottom bar on phones, rail on Windows), and an honest idle
mini-player. Every section shows a truthful "coming online in a later milestone"
state — no mock buttons, per the master prompt's implementation standards.

The full local music player (Phase 1), accounts (Phase 2), social (Phase 3),
and the WebRTC broadcast system (Phase 4) are implemented on top of this shell
following `PlatIt_Architecture_and_Roadmap.md`.

## Notes

- The CI workflow uses `flutter create` to generate platform folders
  (`android/`, `ios/`, `windows/`) — committing those is optional.
- Before store release: replace the debug APK with a signed release build
  (upload key via `--split-per-abi` + signing config), and swap in the real
  `assets/logo.png` brand asset.
