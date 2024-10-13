import '../../bgmd.dart';

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverPinnedAppBar(
      title: context.l10n.bangumi,
      actions: const [DisplayModeButton()],
    );
  }
}

final _tokeMoreProvider = StateProvider<int>((ref) => 1);

class BangumiFragment extends ConsumerWidget {
  const BangumiFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasons = ref.watch(bangumiSeasonProvider);
    final take = ref.watch(_tokeMoreProvider);
    final slivers = <Widget>[const _Title()];
    for (final season in seasons.take(take)) {
      final children = <Widget>[
        SliverPinnedHeader(
          child: Transform.translate(
            offset: const Offset(0.0, -1.0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        season.season.labelWithNum(context, season.year, season.num),
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(8.0, 0.0),
                      child: TransitionContainer(
                        next: ProviderScope(
                          overrides: [
                            seasonProvider.overrideWithValue(season),
                          ],
                          child: const SeasonPage(),
                        ),
                        builder: (context, open) {
                          return IconButton(
                            style: const ButtonStyle(visualDensity: VisualDensity.compact),
                            onPressed: open,
                            icon: const Icon(
                              Icons.east,
                              size: 20.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];
      for (final week in season.week) {
        children.add(
          MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: Transform.translate(
                  offset: const Offset(0.0, -2.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(
                        week.weekday.label(context, week.items.length),
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
              ProviderScope(
                overrides: [itemsProvider.overrideWithValue(week.items)],
                child: const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  sliver: BangumiListFragment(),
                ),
              ),
            ],
          ),
        );
      }
      slivers.add(
        MultiSliver(
          pushPinnedChildren: true,
          children: children,
        ),
      );
    }
    slivers.add(SliverGap(context.navBarHeight + 24.0));
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - context.screenHeight) {
          ref.read(_tokeMoreProvider.notifier).state++;
        }
        return false;
      },
      child: CustomScrollView(
        slivers: slivers,
      ),
    );
  }
}
