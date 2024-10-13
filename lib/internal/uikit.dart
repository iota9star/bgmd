import 'dart:core';

import '../bgmd.dart';

extension UIKit on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  Size get screenSize => mediaQueryData.size;

  double get devicePixelRatio => mediaQueryData.devicePixelRatio;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  double get screenRatio => screenWidth / screenHeight;

  EdgeInsets get safePadding => mediaQueryData.padding;

  double get statusBarHeight => safePadding.top;

  double get navBarHeight => safePadding.bottom;

  bool get isHandset => screenWidth < 600.0;

  bool get isFoldableSmallTablet => screenWidth >= 600.0 && screenWidth < 840.0;

  bool get isLargeTablet => screenWidth >= 840.0;

  int get columns {
    if (isHandset) {
      return 4;
    }
    if (isFoldableSmallTablet) {
      return 12;
    }
    if (isLargeTablet) {
      return 12;
    }
    return 12;
  }

  double get margins {
    if (isHandset) {
      return 8.0;
    }
    if (isFoldableSmallTablet) {
      return 12.0;
    }
    if (isLargeTablet) {
      return 16.0;
    }
    return 24.0;
  }

  bool useTabletLayout(TabletMode mode) {
    final bool isTablet;
    switch (mode) {
      case TabletMode.tablet:
        isTablet = true;
      case TabletMode.auto:
        isTablet = isFoldableSmallTablet || isLargeTablet;
      case TabletMode.disable:
        isTablet = false;
    }
    return isTablet;
  }
}

enum TabletMode {
  auto,
  tablet,
  disable,
  ;

  bool get isTablet => this == TabletMode.tablet;

  bool get isAuto => this == TabletMode.auto;

  bool get isDisable => this == TabletMode.disable;

  String label(BuildContext context) {
    switch (this) {
      case TabletMode.tablet:
        return context.l10n.on;
      case TabletMode.auto:
        return context.l10n.auto;
      case TabletMode.disable:
        return context.l10n.off;
    }
  }
}
