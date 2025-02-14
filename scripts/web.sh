#!/bin/bash

git clone -b stable https://github.com/flutter/flutter.git flutter-sdk
export PATH="$PATH:`pwd`/flutter-sdk/bin"
flutter build web --release
dart scripts/web.dart
