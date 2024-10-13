import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

extension Log on Object? {
  void $debug({StackTrace? stackTrace, int level = 2}) {
    d(this, stackTrace: stackTrace, level: level);
  }

  void $info({StackTrace? stackTrace, int level = 2}) {
    i(this, stackTrace: stackTrace, level: level);
  }

  void $warn({StackTrace? stackTrace, int level = 2}) {
    w(this, stackTrace: stackTrace, level: level);
  }

  void $error({
    Object? msg,
    StackTrace? stackTrace,
    int level = 2,
  }) {
    e(
      msg: msg,
      error: this,
      stackTrace: stackTrace,
      level: level,
    );
  }

  static void d(
    Object? msg, {
    StackTrace? stackTrace,
    int level = 1,
  }) {
    if (!kDebugMode) {
      return;
    }
    final track = _trackStackTraceId(StackTrace.current, level);
    _log(
      msg: msg,
      track: track,
      stackTrace: stackTrace,
      level: '💬',
    );
  }

  static void i(
    Object? msg, {
    StackTrace? stackTrace,
    int level = 1,
  }) {
    if (!kDebugMode) {
      return;
    }
    final track = _trackStackTraceId(StackTrace.current, level);
    _log(
      msg: msg,
      track: track,
      stackTrace: stackTrace,
      level: '👾',
    );
  }

  static void w(
    Object? msg, {
    StackTrace? stackTrace,
    int level = 1,
  }) {
    if (!kDebugMode) {
      return;
    }
    final track = _trackStackTraceId(StackTrace.current, level);
    _log(
      msg: msg,
      track: track,
      stackTrace: stackTrace,
      level: '🙌',
    );
  }

  static void e({
    Object? msg,
    Object? error,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    if (!kDebugMode) {
      return;
    }
    final track = _trackStackTraceId(StackTrace.current, level);
    _log(
      msg: msg,
      track: track,
      error: error,
      stackTrace: stackTrace,
      level: '🤡',
    );
  }

  static void catchError(
    Object error,
    StackTrace stackTrace, {
    int level = 1,
  }) {
    if (!kDebugMode) {
      return;
    }
    final track = _trackStackTraceId(StackTrace.current, level);
    _log(
      track: track,
      error: error,
      stackTrace: stackTrace,
      level: '🤡',
    );
  }

  static void _log({
    Object? msg,
    required String level,
    required String track,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();
    if (msg != null) {
      if (msg is Function) {
        msg = msg.call();
      }
      if (msg is Map || msg is Iterable) {
        final encoder = JsonEncoder.withIndent('  ', (o) => o.toString());
        buffer.writeln();
        buffer.write(encoder.convert(msg));
      } else {
        buffer.write(msg);
      }
    }
    log(
      buffer.toString(),
      name: '$track $level',
      time: DateTime.now(),
      stackTrace: stackTrace,
      error: error,
    );
  }

  static String _trackStackTraceId(StackTrace stackTrace, int level) {
    return stackTrace
        .toString()
        .split('\n')[level]
        .replaceAll(RegExp(r'(#\d+\s+)'), '')
        .replaceAll(RegExp('(<anonymous closure>)'), '()')
        // .replaceAll(RegExp(r'\s\((.+?):\d+:\d+\)'), '')
        .replaceAll('. (', '.() (');
  }
}
