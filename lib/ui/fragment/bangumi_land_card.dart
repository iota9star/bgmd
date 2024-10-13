import 'package:jiffy/jiffy.dart';

import '../../bgmd.dart';

class BangumiLandCard extends ConsumerWidget {
  const BangumiLandCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
    final siteMeta = ref.watch(siteMetaProvider);
    final locale = ref.watch(settingsProvider.select((e) => e.locale));
    final title = item.cardTitle(locale);
    final sites = item.sites?.map((e) {
      return e.toSiteWidget(context, siteMeta);
    });
    return TransitionContainer(
      next: ProviderScope(
        overrides: [
          itemProvider.overrideWithValue(item),
        ],
        child: const BangumiPage(),
      ),
      builder: (context, open) {
        return RippleTap(
          onTap: open,
          color: context.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: item.cover.isNullOrBlank
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.theme.scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: const Center(
                                  child: Text(
                                    '🍀',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              )
                            : Image(
                                image: CacheImage(item.cover),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      child: child,
                                    );
                                  }
                                  final expectedTotalBytes = loadingProgress.expectedTotalBytes;
                                  if (expectedTotalBytes == null) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: context.theme.scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '🌝',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      ),
                                    );
                                  }
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.theme.scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${(loadingProgress.cumulativeBytesLoaded / expectedTotalBytes * 100).toStringAsFixed(0)}%',
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.theme.scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '💔',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Positioned(
                        right: 4.0,
                        top: 4.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.colors.primaryContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.25),
                            child: Text(
                              item.type.name.toUpperCase(),
                              style: context.textTheme.labelSmall?.copyWith(
                                height: 1.25,
                                fontSize: 10.0,
                                color: context.colors.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: context.textTheme.titleSmall,
                ),
              ),
              if (!item.begin.isNullOrBlank)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    Jiffy.parse(item.begin).format(pattern: 'yyyy-MM-dd HH:mm'),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              if (!sites.isNullOrEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: sites!.toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
