import '../../bgmd.dart';

class BangumiGridCard extends ConsumerWidget {
  const BangumiGridCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
    final locale = ref.watch(settingsProvider.select((e) => e.locale));
    final title = item.cardTitle(locale);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: TransitionContainer(
            next: ProviderScope(
              overrides: [
                itemProvider.overrideWithValue(item),
              ],
              child: const BangumiPage(),
            ),
            builder: (context, open) {
              return ScalableCard(
                onTap: open,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: item.cover.isNullOrBlank
                          ? const Center(
                              child: Text(
                                '🍀',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            )
                          : Image(
                              image: CacheImage(item.cover),
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
                                return const Center(
                                  child: Text(
                                    '💔',
                                    style: TextStyle(fontSize: 20.0),
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
              );
            },
          ),
        ),
        const Gap(4.0),
        Text(
          '$title\n',
          style: context.textTheme.bodySmall?.copyWith(
            height: 1.25,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
