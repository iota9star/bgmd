import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../bgmd.dart';

final isMobile = Platform.isAndroid || Platform.isIOS;
final isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;

Future<void> hideKeyboard() {
  return SystemChannels.textInput.invokeMethod('TextInput.hide').catchError((_) {});
}

Future<void> copyText(String text) {
  return Clipboard.setData(ClipboardData(text: text));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
  BuildContext context,
  String text, [
  SnackBarAction? action,
]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      action: action,
    ),
  );
}

Future<String> getAppDirectory() async {
  final parent = await getApplicationDocumentsDirectory();
  final dir = path.join(parent.path, 'seed');
  if (!Directory(dir).existsSync()) {
    await Directory(dir).create(recursive: true);
  }
  return dir;
}

Future<void> moveDirectory(Directory source, Directory destination) async {
  if (!source.existsSync()) {
    throw Exception('Source directory does not exist');
  }

  if (!destination.existsSync()) {
    await destination.create(recursive: true);
  }

  await for (final entity in source.list(recursive: false)) {
    if (entity is File) {
      final newFile = File('${destination.path}/${entity.uri.pathSegments.last}');
      await entity.rename(newFile.path);
    } else if (entity is Directory) {
      final newDirectory = Directory('${destination.path}/${entity.uri.pathSegments.last}');
      await moveDirectory(entity, newDirectory);
    }
  }

  await source.delete(recursive: true);
}

Locale getSuggestedLocale() {
  final systemLocale = PlatformDispatcher.instance.locale;
  final languageCode = systemLocale.languageCode;
  final scriptCode = systemLocale.scriptCode;
  if (languageCode == 'zh') {
    return AppLocalizations.supportedLocales.firstWhereOrNull(
          (e) => e.languageCode == languageCode && e.scriptCode == scriptCode,
        ) ??
        AppLocalizations.supportedLocales.firstWhere((e) {
          return e.languageCode == languageCode;
        });
  }
  final locale = AppLocalizations.supportedLocales.firstWhereOrNull(
    (e) => e.languageCode == languageCode && e.scriptCode == scriptCode,
  );
  return locale ?? AppLocalizations.supportedLocales.first;
}

String base64UrlMD5(String data) {
  return base64Url.encode(md5.convert(utf8.encode(data)).bytes);
}

String sanitizeFilename(String input, {String replacement = ''}) {
  final result = input
      // illegalRe
      .replaceAll(
        RegExp(r'[/?<>\\:*|"]'),
        replacement,
      )
      // controlRe
      .replaceAll(
        RegExp(
          r'[\x00-\x1f\x80-\x9f]',
        ),
        replacement,
      )
      // reservedRe
      .replaceFirst(
        RegExp(r'^\.+$'),
        replacement,
      )
      // windowsReservedRe
      .replaceFirst(
        RegExp(
          r'^(con|prn|aux|nul|com[0-9]|lpt[0-9])(\..*)?$',
          caseSensitive: false,
        ),
        replacement,
      )
      // windowsTrailingRe
      .replaceFirst(RegExp(r'[. ]+$'), replacement);

  return result.length > 255 ? result.substring(0, 255) : result;
}

typedef Recurrence = (DateTime, int, DateTime);

Recurrence? parseRecurrence(String recurrenceString) {
  try {
    final split = recurrenceString.split('/');
    final startTimeString = split[1];
    final startTime = DateTime.parse(startTimeString);

    final periodString = split[2];
    final regex = RegExp(r'P(?:(\d+)D)?');
    final match = regex.firstMatch(periodString);

    if (match == null) {
      return null;
    }

    final days = int.tryParse(match.group(1) ?? '0') ?? 0;
    final period = Duration(days: days);

    final now = DateTime.now().toUtc();
    DateTime nextOccurrence = startTime;

    while (nextOccurrence.isBefore(now)) {
      nextOccurrence = nextOccurrence.add(period);
    }
    return (startTime, days, nextOccurrence);
  } catch (e) {
    return null;
  }
}
