/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class Assets {
  Assets._();

  static const AssetGenImage abema = AssetGenImage('assets/abema.png');
  static const AssetGenImage acfun = AssetGenImage('assets/acfun.png');
  static const AssetGenImage alipay = AssetGenImage('assets/alipay.png');
  static const AssetGenImage bangumi = AssetGenImage('assets/bangumi.png');
  static const AssetGenImage bilibili = AssetGenImage('assets/bilibili.png');
  static const AssetGenImage disneyplus =
      AssetGenImage('assets/disneyplus.png');
  static const AssetGenImage dmhy = AssetGenImage('assets/dmhy.png');
  static const SvgGenImage gamer = SvgGenImage('assets/gamer.svg');
  static const AssetGenImage iqiyi = AssetGenImage('assets/iqiyi.png');
  static const AssetGenImage letv = AssetGenImage('assets/letv.png');
  static const AssetGenImage mgtv = AssetGenImage('assets/mgtv.png');
  static const AssetGenImage mikan = AssetGenImage('assets/mikan.png');
  static const AssetGenImage mytv = AssetGenImage('assets/mytv.png');
  static const AssetGenImage netflix = AssetGenImage('assets/netflix.png');
  static const AssetGenImage nicovideo = AssetGenImage('assets/nicovideo.png');
  static const SvgGenImage qq = SvgGenImage('assets/qq.svg');
  static const SvgGenImage unext = SvgGenImage('assets/unext.svg');
  static const AssetGenImage viu = AssetGenImage('assets/viu.png');
  static const AssetGenImage wechatpay = AssetGenImage('assets/wechatpay.png');
  static const SvgGenImage youku = SvgGenImage('assets/youku.svg');
  static const SvgGenImage youtube = SvgGenImage('assets/youtube.svg');
  static const AssetGenImage bgmd = AssetGenImage('bgmd.png');

  /// List of all assets
  static List<dynamic> get values => [
        abema,
        acfun,
        alipay,
        bangumi,
        bilibili,
        disneyplus,
        dmhy,
        gamer,
        iqiyi,
        letv,
        mgtv,
        mikan,
        mytv,
        netflix,
        nicovideo,
        qq,
        unext,
        viu,
        wechatpay,
        youku,
        youtube,
        bgmd
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
