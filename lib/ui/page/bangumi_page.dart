import 'dart:ui' as ui;
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../bgmd.dart';

class BangumiPage extends ConsumerStatefulWidget {
  const BangumiPage({super.key});

  @override
  ConsumerState createState() => _BangumiPageState();
}

class _BangumiPageState extends ConsumerState<BangumiPage> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final siteMeta = ref.watch(siteMetaProvider);
    final item = ref.watch(itemProvider);
    final locale = ref.watch(settingsProvider.select((e) => e.locale));
    final title = item.cardTitle(locale);
    final sites = item.sites?.map((e) {
      return e.toSiteWidget(context, siteMeta);
    });
    final tags = [item.type.name.toUpperCase()];
    if (!item.broadcast.isNullOrBlank) {
      final recurrence = parseRecurrence(item.broadcast!);
      if (recurrence != null) {
        tags.add(Jiffy.parseFromDateTime(recurrence.$1).format(pattern: 'yyyy-MM-dd HH:mm'));
        if (item.end.isNullOrBlank) {
          tags.add(Jiffy.parseFromDateTime(recurrence.$3).fromNow());
        } else {
          final end = Jiffy.parse(item.end!);
          if (end.isBefore(Jiffy.now())) {
            tags.add(end.format(pattern: 'yyyy-MM-dd HH:mm'));
          } else {
            tags.add(Jiffy.parseFromDateTime(recurrence.$3).fromNow());
          }
        }
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(image: CacheImage(item.cover), fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor.withOpacity(0.78)),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: context.statusBarHeight + 24.0,
                      bottom: context.navBarHeight + 24.0,
                    ),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Material(
                        elevation: 1.0,
                        color: context.cardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Material(
                                color: context.theme.scaffoldBackgroundColor,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                elevation: 1.0,
                                child: Stack(
                                  children: [
                                    Image(
                                      image: CacheImage(
                                        item.cover,
                                        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                                      ),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        final expectedTotalBytes = loadingProgress.expectedTotalBytes;
                                        if (expectedTotalBytes == null) {
                                          return const AspectRatio(
                                            aspectRatio: 3 / 4,
                                            child: Center(child: Text('🌝', style: TextStyle(fontSize: 20.0))),
                                          );
                                        }
                                        return AspectRatio(
                                          aspectRatio: 3 / 4,
                                          child: Center(
                                            child: Text(
                                              '${(loadingProgress.cumulativeBytesLoaded / expectedTotalBytes * 100).toStringAsFixed(0)}%',
                                              style: const TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const AspectRatio(
                                          aspectRatio: 3 / 4,
                                          child: Center(child: Text('💔', style: TextStyle(fontSize: 20.0))),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      left: 4.0,
                                      right: 4.0,
                                      top: 4.0,
                                      child: Wrap(
                                        alignment: WrapAlignment.end,
                                        spacing: 4.0,
                                        runSpacing: 4.0,
                                        children: tags
                                            .map((e) {
                                              return DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: context.colors.primaryContainer,
                                                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.25),
                                                  child: Text(
                                                    e,
                                                    style: context.textTheme.labelSmall?.copyWith(
                                                      height: 1.25,
                                                      fontSize: 10.0,
                                                      color: context.colors.onPrimaryContainer,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                            .toList(growable: false),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(8.0),
                              Text(title, style: context.textTheme.titleMedium, textAlign: TextAlign.center),
                              if (!item.officialSite.isNullOrBlank)
                                RippleTap(
                                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                                  onTap: () {
                                    launchUrlString(item.officialSite!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          context.l10n.officialSite,
                                          style: context.textTheme.bodySmall?.copyWith(fontSize: 10.0),
                                        ),
                                        const Gap(4.0),
                                        Text(
                                          Uri.parse(item.officialSite!).host,
                                          style: context.textTheme.bodySmall?.copyWith(fontSize: 10.0),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const Gap(8.0),
                              if (!sites.isNullOrEmpty)
                                ProviderScope(
                                  overrides: [itemProvider.overrideWithValue(item)],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Wrap(spacing: 4.0, runSpacing: 4.0, children: sites!.toList()),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12.0,
            right: 12.0,
            top: context.statusBarHeight + 12.0,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.west),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    try {
                      final boundary = globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
                      final image = await boundary.toImage(pixelRatio: 3.0);
                      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                      final pngBytes = byteData?.buffer.asUint8List();
                      final s = await saveFile('$title.png', pngBytes!, fileType: FileType.image);
                      Log.d(s);
                      if (s.isNullOrBlank) {
                        showSnackbar(context, context.l10n.saveFailed);
                        return;
                      }
                      showSnackbar(context, context.l10n.saveSuccess(s!));
                    } catch (e, s) {
                      Log.e(error: e, stackTrace: s);
                    }
                  },
                  icon: const Icon(Icons.satellite_outlined),
                ),
                ValueListenableBuilder(
                  valueListenable: HiveBoxes.collections.listenable(keys: [item.title]),
                  builder: (context, v, child) {
                    final favorite = v.containsKey(item.title);
                    return IconButton(
                      onPressed: () {
                        if (favorite) {
                          v.delete(item.title);
                        } else {
                          v.put(item.title, item.toBangumi());
                        }
                      },
                      icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
