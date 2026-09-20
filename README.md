# Keep Clone — Offline-First Google Keep (Flutter)

100% offline Google Keep clone. Zero network permissions, 120 FPS masonry grid, instant FTS. Targets **Android + iOS** only.

## Features
- **Home:** Search bar (local FTS, 220ms debounce), 2-col staggered masonry ↔ single column toggle, pinned/others sections, bottom quick-create bar (Checklist / Drawing placeholder / Audio placeholder / Image / Text).
- **Editor:** Debounced auto-save (380ms), checklist with swipe-to-delete, bold/italic (*, ** wraps), color picker (12 Keep tints), label tags, pin/archive/trash, local image attachments via `image_picker` → `appDocuments/media/<noteId>/`.
- **DB:** Isar 3.1.0+1 (zero-copy, ACID, `watch()` streams), `compute()` isolate ranking for >100 records, synchronous `warmCache()` on startup.

## Stack
Flutter 3.47 / Dart 3.13, Isar + `isar_flutter_libs`, Riverpod 2.6, `flutter_staggered_grid_view`, `path_provider`, `image_picker`, `uuid`.

## Disk / Offline Optimizations
- No `google_fonts` (would fetch fonts over network; uses system `ThemeData` instead)
- No `intl` / `flutter_colorpicker` (trimmed; custom 12-color strip)
- No `linux/macos/windows/web` platforms (≈600K saved, mobile-only)
- `android/app/src/main/AndroidManifest.xml` has **no `INTERNET`**; `Info.plist` has `NSAllowsArbitraryLoads=false`
- Tracked repo size ≈ **724K** (excluding `.dart_tool` 55M which is gitignored); `*.g.dart` (156K) is committed for zero-setup clone

## Getting Started
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs  # regenerates lib/models/*.g.dart if needed
flutter run          # android/ios
flutter analyze
flutter test
```

## Project Layout
```
lib/
  main.dart
  models/          # note.dart, label.dart, attachment.dart (+ .g.dart)
  core/database/   # isar_service.dart, providers.dart
  core/utils/      # debouncer.dart, note_colors.dart
  features/home/   # home_screen.dart
  features/editor/ # note_editor_screen.dart
  widgets/         # note_card.dart, search_bar.dart, bottom_create_bar.dart
android/app/src/main/AndroidManifest.xml  # offline-only
ios/Runner/Info.plist                     # offline-only + 120 FPS flag
```

## GitHub
```bash
git init
git add .
git commit -m "feat: offline Keep clone"
gh repo create keep_clone --public --source=. --push
# or: git remote add origin <url> && git push -u origin main
```
`pubspec.lock` is committed (recommended for apps). `.env` / `*.jks` / `local.properties` are ignored.

## License
MIT (or Apache-2.0 to match Isar) — add a `LICENSE` file before publishing.
