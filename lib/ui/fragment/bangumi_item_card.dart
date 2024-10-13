import '../../bgmd.dart';

class BangumiItemCard extends ConsumerWidget {
  const BangumiItemCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bangumi = ref.watch(bangumiProvider);
    final item = bangumi.item;
    final cover = item.cover;
    final locale = ref.watch(settingsProvider.select((e) => e.locale));
    final title = item.cardTitle(locale);
    return TransitionContainer(
      next: ProviderScope(
        overrides: [
          itemProvider.overrideWithValue(item),
        ],
        child: const BangumiPage(),
      ),
      builder: (context, open) {
        return ScalableCard(
          onTap: open,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: cover.isNullOrBlank
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
                            : Material(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                child: Image(
                                  image: CacheImage(cover),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    final expectedTotalBytes = loadingProgress.expectedTotalBytes;
                                    if (expectedTotalBytes == null) {
                                      return const Center(
                                        child: Text(
                                          '🌝',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: Text(
                                        '${(loadingProgress.cumulativeBytesLoaded / expectedTotalBytes * 100).toStringAsFixed(0)}%',
                                        style: const TextStyle(fontSize: 20.0),
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
                      ),
                      Positioned(
                        left: 4.0,
                        right: 4.0,
                        top: 4.0,
                        child: Wrap(
                          runSpacing: 4.0,
                          spacing: 4.0,
                          alignment: WrapAlignment.end,
                          children: [
                            item.type.name,
                            bangumi.year.toString(),
                            bangumi.season.labelShort(context),
                            bangumi.week.labelShort(context),
                          ]
                              .map((e) => DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: context.colors.primaryContainer,
                                      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.25),
                                      child: Text(
                                        e.toUpperCase(),
                                        style: context.textTheme.labelSmall?.copyWith(
                                          fontSize: 10.0,
                                          color: context.colors.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),)
                              .toList(growable: false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  title,
                  style: context.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
