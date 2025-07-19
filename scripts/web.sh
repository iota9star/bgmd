#!/bin/bash

git clone -b stable https://github.com/flutter/flutter.git flutter-sdk
export PATH="$PATH:`pwd`/flutter-sdk/bin"
flutter build web --release --tree-shake-icons
dart scripts/web.dart
