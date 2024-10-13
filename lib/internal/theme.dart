import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';


typedef ColorSchemePair = (ColorScheme, ColorScheme);

Future<ColorSchemePair?> getDynamicColorScheme() async {
  final corePalette =
      await DynamicColorPlugin.getCorePalette().catchError((Object? e, s) {
    return null;
  });
  if (corePalette != null) {
    return (
      corePalette.toColorScheme(),
      corePalette.toColorScheme(brightness: Brightness.dark)
    );
  }
  final accentColor =
      await DynamicColorPlugin.getAccentColor().catchError((Object? e, s) {
    return null;
  });
  if (accentColor != null) {
    return (
      ColorScheme.fromSeed(seedColor: accentColor),
      ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: Brightness.dark,
      )
    );
  }
  return null;
}
