import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bgmd.dart';

extension L10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AsyncValueExtension on AsyncValue {
  bool get valueNotNull => hasValue && value != null;
}

extension IterableExt<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isSafeNotEmpty => !isNullOrEmpty;

  T? getOrNull(int index) {
    if (isNullOrEmpty) {
      return null;
    }
    return this!.elementAt(index);
  }

  bool eq(Iterable<T>? other) {
    if (this == null) {
      return other == null;
    }
    if (other == null || this!.length != other.length) {
      return false;
    }
    for (int index = 0; index < this!.length; index += 1) {
      if (this!.elementAt(index) != other.elementAt(index)) {
        return false;
      }
    }
    return true;
  }

  bool ne(Iterable<T> other) => !eq(other);
}

extension BoolExt on bool {
  bool get inv => !this;
}

extension ListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  T? getOrNull(int index) {
    if (isNullOrEmpty) {
      return null;
    }
    if (index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }

  bool eq(List<T>? other) {
    if (this == null) {
      return other == null;
    }
    if (other == null || this!.length != other.length) {
      return false;
    }
    for (int index = 0; index < this!.length; index += 1) {
      if (this![index] != other[index]) {
        return false;
      }
    }
    return true;
  }

  bool ne(List<T>? other) => !eq(other);
}

extension MapExt<K, V> on Map<K, V>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isSafeNotEmpty => !isNullOrEmpty;

  bool eq(Map<K, V>? other) {
    if (this == null) {
      return other == null;
    }
    if (other == null || this!.length != other.length) {
      return false;
    }
    for (final K key in this!.keys) {
      if (!other.containsKey(key) || other[key] != this![key]) {
        return false;
      }
    }
    return true;
  }

  bool ne(Map<K, V>? other) => !eq(other);
}

extension NullableStringExt on String? {
  bool get isNullOrBlank => this == null || this!.isBlank;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotBlank => this != null && !this!.isBlank;

  void toast() {
    if (isNullOrBlank) {
      return;
    }
    SmartDialog.showToast(
      this!,
      alignment: const Alignment(0.0, 0.72),
    );
    HapticFeedback.mediumImpact();
  }

  Future<void> launchAppAndCopy() async {
    if (isNullOrBlank) {
      return '内容为空，取消操作'.toast();
    }

    Future doOtherAction() async {
      if (await canLaunchUrlString(this!)) {
        await launchUrlString(this!, mode: LaunchMode.externalApplication);
      } else {
        '未找到可打开应用'.toast();
      }
    }

    await Clipboard.setData(ClipboardData(text: this!));
    if (Platform.isAndroid) {
      unawaited(
        AndroidIntent(
          action: 'android.intent.action.VIEW',
          flags: [
            Flag.FLAG_ACTIVITY_NEW_TASK,
            Flag.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED,
          ],
          data: this,
        ).launch().catchError((e, s) async {
          e.debug(stackTrace: s);
          await doOtherAction();
        }),
      );
    } else {
      await doOtherAction();
    }
  }

  void copy() {
    if (isNullOrBlank) {
      return '内容为空，取消操作'.toast();
    }
    Clipboard.setData(ClipboardData(text: this!)).then((_) => '已复制到剪切板'.toast());
  }

  void share() {
    if (isNullOrBlank) {
      return '内容为空，取消操作'.toast();
    }
    Share.share(this!);
    Clipboard.setData(ClipboardData(text: this!)).then((_) => '已复制到剪切板'.toast());
  }
}

extension StringExt on String {
  bool get isBlank {
    if (length == 0) {
      return true;
    }
    for (final int value in runes) {
      if (!_isWhitespace(value)) {
        return false;
      }
    }
    return true;
  }

  bool _isWhitespace(int rune) =>
      (rune >= 0x0009 && rune <= 0x000D) ||
      rune == 0x0020 ||
      rune == 0x0085 ||
      rune == 0x00A0 ||
      rune == 0x1680 ||
      rune == 0x180E ||
      (rune >= 0x2000 && rune <= 0x200A) ||
      rune == 0x2028 ||
      rune == 0x2029 ||
      rune == 0x202F ||
      rune == 0x205F ||
      rune == 0x3000 ||
      rune == 0xFEFF;

  String fillChar(String value, String char) {
    final int offset = value.length - length;
    String newVal = this;
    if (offset > 0) {
      for (int i = 0; i < offset; i++) {
        newVal = char + newVal;
      }
    }
    return newVal;
  }

  String basename() {
    final basename = path.basename(this);
    return basename.split('?').first;
  }
}

/// https://stackoverflow.com/a/50081214/10064463
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

const SystemUiOverlayStyle lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

const SystemUiOverlayStyle darkSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

extension BuildContextExt on BuildContext {
  SystemUiOverlayStyle get fitSystemUiOverlayStyle {
    return theme.brightness == Brightness.dark ? lightSystemUiOverlayStyle : darkSystemUiOverlayStyle;
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  Color get cardColor {
    return ElevationOverlay.applySurfaceTint(
      theme.cardColor,
      colors.surfaceTint,
      1.0,
    );
  }
}

extension BrightnessColor on Color {
  static Color lightRandom() {
    return HSLColor.fromAHSL(
      1,
      math.Random().nextDouble() * 360,
      0.5,
      0.75,
    ).toColor();
  }

  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}

extension ColorExt on Color {
  bool get isDark {
    return computeLuminance() < 0.5;
  }
}

extension ThemeDataExt on ThemeData {
  Color get primary => colorScheme.primary;

  Color get secondary => colorScheme.secondary;
}

extension StateExt on State {
  void setSafeState(VoidCallback cb) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(cb);
    }
  }
}

extension LocaleExt on Locale {
  String label(BuildContext context) {
    if (languageCode == 'zh') {
      if (scriptCode == 'Hant') {
        return context.l10n.zhHant;
      }
      return context.l10n.zh;
    } else if (languageCode == 'en') {
      return context.l10n.en;
    } else if (languageCode == 'ja') {
      return context.l10n.ja;
    }
    throw Exception('Unsupported language code: $languageCode');
  }
}

extension ChangeNotifierWithCodeGenExtension on Ref {
  T listenAndDisposeChangeNotifier<T extends ChangeNotifier>(T notifier) {
    notifier.addListener(notifyListeners);
    onDispose(() => notifier.removeListener(notifyListeners));
    onDispose(notifier.dispose);
    return notifier;
  }
}
