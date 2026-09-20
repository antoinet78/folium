#!/bin/bash
# Re-apply Isar namespace fix after `flutter pub get` (pub-cache is ephemeral)
set -e
FILE="$HOME/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle"
if [ -f "$FILE" ]; then
  if grep -q "namespace 'dev.isar" "$FILE"; then
    echo "Isar already patched"
    exit 0
  fi
  cat > "$FILE" <<'GRADLE'
group 'dev.isar.isar_flutter_libs'
version '1.0'

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.7.3'
    }
}

rootProject.allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

apply plugin: 'com.android.library'

android {
    namespace 'dev.isar.isar_flutter_libs'
    compileSdk 34

    defaultConfig {
        minSdk 16
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
}

dependencies {
    implementation "androidx.startup:startup-runtime:1.1.1"
}
GRADLE
  echo "Patched $FILE"
else
  echo "Isar not in pub-cache yet, run flutter pub get first"
fi
