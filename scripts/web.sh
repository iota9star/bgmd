#!/bin/bash

git clone -b 3.27.4 https://github.com/flutter/flutter.git flutter-sdk
export PATH="$PATH:`pwd`/flutter-sdk/bin"
flutter build web --release --web-renderer html
dart scripts/web.dart
