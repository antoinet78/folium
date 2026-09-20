# Folium — Offline Notes (Flutter)

100% offline notes. Zero network permissions, 120 FPS masonry grid, instant FTS. Targets **Android + iOS** only. Original brand — not a Keep copy.

> **Brand:** Warm stone `#F5F1E8` + forest `#2D4A22` + leaf icon (3 stacked papers + vein). Splash: centered 360dp logo on stone with “Folium — offline notes”.

## Features
- **Home:** Search bar (local FTS, 220ms debounce), 2-col staggered masonry ↔ single column toggle, pinned/others sections, bottom quick-create bar (Checklist / Drawing placeholder / Audio placeholder / Image / Text).
- **Editor:** Debounced auto-save (380ms), checklist with swipe-to-delete, bold/italic (*, ** wraps), color picker (12 tints on stone palette), label tags, pin/archive/trash, local image attachments via `image_picker` → `appDocuments/media/<noteId>/`.
- **DB:** Isar 3.1.0+1 (zero-copy, ACID, `watch()` streams), `compute()` isolate ranking for >100 records, synchronous `warmCache()` on startup.

## Stack
Flutter 3.47 / Dart 3.13, Isar + `isar_flutter_libs`, Riverpod 2.6, `flutter_staggered_grid_view`, `path_provider`, `image_picker`, `uuid`.

## Branding (original, not copied)
- **Name:** Folium (Latin for leaf) — package `folium` / `com.folium.app`
- **Icon:** `/android/app/src/main/res/mipmap-*/ic_launcher.png` (48-192dp) + `ios/Runner/Assets.xcassets/AppIcon.appiconset/` (20-1024) — generated from `master_1024.png` via Pillow, no Keep assets
- **Splash:** `android/.../res/drawable/splash.png` (1080×1920, logo centred on `#F5F1E8`) via `launch_background.xml`; `ios/.../LaunchImage.imageset/` (168/336/504) + `LaunchScreen.storyboard` (centered `LaunchImage`)
- **Theme:** `ColorScheme.fromSeed(seedColor: #2D4A22)` + stone surfaces

## Disk / Offline Optimizations
- No `google_fonts` (would fetch fonts over network; uses system `ThemeData`)
- No `intl` / `flutter_colorpicker` (trimmed; custom 12-color strip)
- No `linux/macos/windows/web` platforms (≈600K saved, mobile-only)
- `android/app/src/main/AndroidManifest.xml` has **no `INTERNET`**; `Info.plist` has `NSAllowsArbitraryLoads=false`
- Tracked repo ≈ **~730K** (excluding `.dart_tool` 55M gitignored); `*.g.dart` (156K) committed for zero-setup clone

## Getting Started
```bash
flutter pub get
# Isar 3.1.0+1 needs namespace patch for AGP 9.1/Gradle 9.3 (one-time after each pub get)
./tool/patch_isar.sh
dart run build_runner build --delete-conflicting-outputs  # regenerates lib/models/*.g.dart if needed
flutter run          # android/ios (tested SM-A137F A13)
flutter analyze
flutter test
```

### Troubleshooting - Samsung A13 / AGP 9.1
```
FAILURE: Namespace not specified. Specify a namespace in module isar_flutter_libs
```
Fix: `isar_flutter_libs-3.1.0+1` predates namespaces. This repo patches it:
```bash
./tool/patch_isar.sh  # adds namespace 'dev.isar.isar_flutter_libs' + compileSdk 34
flutter clean && flutter build apk --debug  # now builds in ~16s incremental, 104s first
```
The patch edits `~/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle` (ephemeral) + is documented in `tool/patch_isar.sh`. No `INTERNET` added — still offline.

## Project Layout
```
lib/
  main.dart                          # FoliumApp (#2D4A22 seed)
  models/          # note.dart, label.dart, attachment.dart (+ .g.dart)
  core/database/   # isar_service.dart (db name 'folium'), providers.dart
  core/utils/      # debouncer.dart, note_colors.dart
  features/home/   # home_screen.dart (Folium drawer, eco icons)
  features/editor/ # note_editor_screen.dart
  widgets/         # note_card.dart, search_bar.dart, bottom_create_bar.dart
android/app/src/main/res/drawable/splash.png
android/app/src/main/res/mipmap-*/ic_launcher.png
ios/Runner/Assets.xcassets/AppIcon.appiconset/
ios/Runner/Assets.xcassets/LaunchImage.imageset/
```

## Rename (if you want another name)
```bash
# 1. pubspec.yaml name: folium -> myname
# 2. android/app/build.gradle.kts namespace + applicationId: com.folium.app -> com.myname.app
# 3. android/app/src/main/kotlin/com/folium/app/ -> com/myname/app + package line
# 4. android/app/src/main/AndroidManifest.xml android:label
# 5. ios/Runner/Info.plist CFBundleDisplayName / CFBundleName
# 6. lib/core/database/isar_service.dart Isar name
# 7. grep -r folium lib -> update imports if you move dir
```

## GitHub
```bash
git status
git add .
git commit -m "feat: rebrand to Folium — original icons + splash"
gh repo create folium --public --source=. --push
# or: git remote add origin https://github.com/<you>/folium.git && git push -u origin main
```
`pubspec.lock` committed (recommended for apps). `.env` / `*.jks` / `local.properties` ignored.

## License
MIT (or Apache-2.0 to match Isar) — add a `LICENSE` file before publishing.
