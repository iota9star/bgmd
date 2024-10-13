#!/bin/bash

git clone --depth 1 -b stable https://github.com/flutter/flutter.git flutter-sdk
export PATH="$PATH:`pwd`/flutter-sdk/bin"
flutter build web --release --web-renderer html
dart scripts/web.dart
