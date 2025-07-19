import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:path/path.dart';

import '../bgmd.dart';

@immutable
class CacheImage extends painting.ImageProvider<painting.NetworkImage> implements painting.NetworkImage {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments [url] and [scale] must not be null.
  const CacheImage(
    this.url, {
    this.scale = 1.0,
    this.headers,
    this.webHtmlElementStrategy = painting.WebHtmlElementStrategy.never,
  });

  @override
  final String url;

  @override
  final double scale;

  @override
  final Map<String, String>? headers;

  @override
  final painting.WebHtmlElementStrategy webHtmlElementStrategy;

  @override
  Future<CacheImage> obtainKey(painting.ImageConfiguration configuration) {
    return SynchronousFuture<CacheImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(painting.NetworkImage key, painting.ImageDecoderCallback decode) {
    // Ownership of this controller is handed off to [_loadAsync]; it is that
    // method's responsibility to close the controller's stream when the image
    // has been loaded or an error is thrown.
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key as CacheImage, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<painting.ImageProvider>('Image provider', this),
        DiagnosticsProperty<painting.NetworkImage>('Image key', key),
      ],
    );
  }

  // Do not access this field directly; use [_httpClient] instead.
  // We set `autoUncompress` to false to ensure that we can trust the value of
  // the `Content-Length` HTTP header. We automatically uncompress the content
  // in our call to [consolidateHttpClientResponseBytes].
  static final HttpClient _sharedHttpClient = HttpClient()..autoUncompress = false;

  static HttpClient get _httpClient {
    HttpClient client = _sharedHttpClient;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }());
    return client;
  }

  Future<ui.Codec> _loadAsync(
    CacheImage key,
    StreamController<ImageChunkEvent> chunkEvents,
    Future<ui.Codec> Function(ui.ImmutableBuffer) decode,
  ) async {
    try {
      assert(key == this);
      chunkEvents.add(const ImageChunkEvent(cumulativeBytesLoaded: 1, expectedTotalBytes: 100));
      final cacheKey = base64Url.encode(utf8.encode(key.url));
      final cacheFile = await _getCacheFile(cacheKey);
      if (cacheFile.existsSync()) {
        final buffer = await ui.ImmutableBuffer.fromFilePath(cacheFile.path);
        return decode(buffer);
      }

      final Uri resolved = Uri.base.resolve(key.url);
      final HttpClientRequest request = await _httpClient.getUrl(resolved);

      headers?.forEach((String name, String value) {
        request.headers.add(name, value);
      });
      final HttpClientResponse response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        // The network may be only temporarily unavailable, or the file will be
        // added on the server later. Avoid having future calls to resolve
        // fail to check the network again.
        await response.drain<List<int>>(<int>[]);
        throw painting.NetworkImageLoadException(statusCode: response.statusCode, uri: resolved);
      }

      final Uint8List bytes = await consolidateHttpClientResponseBytes(
        response,
        onBytesReceived: (int cumulative, int? total) {
          chunkEvents.add(ImageChunkEvent(cumulativeBytesLoaded: cumulative, expectedTotalBytes: total));
        },
      );
      if (bytes.lengthInBytes == 0) {
        throw Exception('NetworkImage is an empty file: $resolved');
      }
      final ui.Codec codec;
      try {
        final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
        codec = await decode(buffer);
      } finally {
        try {
          final file = await _getCacheFile('$cacheKey.tmp');
          await file.writeAsBytes(bytes);
          await file.rename(cacheFile.path);
        } catch (_) {}
      }
      return codec;
    } catch (e) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      unawaited(chunkEvents.close());
    }
  }

  Future<File> _getCacheFile(String fileName) async {
    final String cacheDir = AppSettings().imageCacheDir;
    final dir = Directory(cacheDir);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return File(join(dir.path, fileName));
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CacheImage && other.url == url && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(url, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'NetworkImage')}("$url", scale: $scale)';
}
